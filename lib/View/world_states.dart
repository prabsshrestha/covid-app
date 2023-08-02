import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Services/states_services.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff42B5F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height * .01),
        FutureBuilder(
            future: statesServices.fetchWorldStatesRecord(),
            builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,
                  ),
                );
              } else {
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        "Total": double.parse(snapshot.data!.cases!.toString()),
                        "Recovered":
                            double.parse(snapshot.data!.recovered.toString()),
                        "Deaths":
                            double.parse(snapshot.data!.deaths.toString()),
                      },
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      chartRadius: MediaQuery.of(context).size.width / 4.0,
                      legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left),
                      animationDuration: const Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * .04),
                      child: Card(
                          child: Column(
                        children: [
                          ReusableRow(
                            title: 'Total Cases',
                            value: snapshot.data!.cases.toString(),
                          ),
                          ReusableRow(
                            title: 'Deaths',
                            value: snapshot.data!.deaths.toString(),
                          ),
                          ReusableRow(
                            title: 'Recovered',
                            value: snapshot.data!.recovered.toString(),
                          ),
                          ReusableRow(
                            title: 'Active Cases',
                            value: snapshot.data!.active.toString(),
                          ),
                          ReusableRow(
                            title: 'Critical Cases',
                            value: snapshot.data!.critical.toString(),
                          ),
                          ReusableRow(
                            title: 'Today Cases',
                            value: snapshot.data!.todayCases.toString(),
                          ),
                          ReusableRow(
                            title: 'Today Recovered',
                            value: snapshot.data!.todayRecovered.toString(),
                          ),
                          ReusableRow(
                            title: 'Today Deaths',
                            value: snapshot.data!.todayDeaths.toString(),
                          ),
                        ],
                      )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountriesListScreen()));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Track Countries',
                            style: GoogleFonts.laila(
                                textStyle:
                                    TextStyle(fontSize: 20, letterSpacing: .5)),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ]),
    )));
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 7,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Divider(),
        ],
      ),
    );
  }
}
