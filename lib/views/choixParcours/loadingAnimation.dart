import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Lottie.asset('assets/Loading.json', width: 300, height: 300),
        Gap(20),
        Text('Bon apprentisage', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18
        ))
      ],)
    ),);
  }
}