import 'package:flutter/material.dart';

class Cours extends StatefulWidget {
  const Cours({super.key});

  @override
  State<Cours> createState() => _CoursState();
}

class _CoursState extends State<Cours> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Cours', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}