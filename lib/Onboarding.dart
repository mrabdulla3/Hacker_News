import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboarding();
}

class _onboarding extends State<onboarding> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this)
      ..value = 0.01
      ..addListener(() {
        setState(() {
          if (_controller.isCompleted)
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'Hacker News App',
                        )));
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(45),
          child: Lottie.asset(
            'assets/onboarding.json',
            onLoaded: (composition) {
              setState(() {
                _controller
                  ..duration = composition.duration
                  ..forward();
              });
            },
          ),
        ),
      ),
    );
  }
}
