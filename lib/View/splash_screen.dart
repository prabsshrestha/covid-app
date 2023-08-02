import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:covid_tracker/View/world_states.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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

  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        const Duration(seconds: 7),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorldStatesScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: MediaQuery.of(context).size.height * .25,
                  width: MediaQuery.of(context).size.width * .5,
                  child: const Center(
                      child: Image(image: AssetImage('images/virus.png'))),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 4.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'COVID-19\nTracker App',
                textAlign: TextAlign.center,
                style: GoogleFonts.laila(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 105, 169, 107),
                        fontSize: 30,
                        letterSpacing: .5)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
