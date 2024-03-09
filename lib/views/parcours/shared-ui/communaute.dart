import 'package:flutter/material.dart';

class Communaute extends StatefulWidget {
  const Communaute({super.key});

  @override
  State<Communaute> createState() => _CommunauteState();
}

class _CommunauteState extends State<Communaute> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Communaute'),
      ),
    );
  }
}