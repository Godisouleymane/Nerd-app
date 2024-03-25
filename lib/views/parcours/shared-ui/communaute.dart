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
      backgroundColor: Colors.white,
      body: const Center(
        child: Text('Communaute'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
