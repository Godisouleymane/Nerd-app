import 'package:flutter/material.dart';

class Cours extends StatefulWidget {
  const Cours({super.key});

  @override
  State<Cours> createState() => _CoursState();
}

class _CoursState extends State<Cours> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: const Center(
        child: Text('Cours', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}