import 'package:flutter/material.dart';

class LoginPqge extends StatelessWidget {
  const LoginPqge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
            Expanded(
              child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.60),
              )
          ],
        ),
       
      ], ),
    );
  }
}
