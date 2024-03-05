import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                        child: const Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/logo.webp'),
                            radius: 70,
                            )
                        ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.4, // Ajustez cette valeur pour déplacer le conteneur blanc vers le haut
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Authentification', style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                  
                ],
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
