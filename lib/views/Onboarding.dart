import 'package:flutter/material.dart';
import 'package:hacker_news/views/home.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _onboarding();
}

class _onboarding extends State<Onboarding> with TickerProviderStateMixin {
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
                context, MaterialPageRoute(builder: (context) => const Home()));
        });
      });
  }
  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
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
