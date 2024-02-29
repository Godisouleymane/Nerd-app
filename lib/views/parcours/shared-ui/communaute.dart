import 'package:flutter/material.dart';

class Communaute extends StatefulWidget {
  const Communaute({super.key});

  @override
  State<Communaute> createState() => _CommunauteState();
}

class _CommunauteState extends State<Communaute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: const Center(
        child: Text('Communaute'),
      ),
    );
  }
}