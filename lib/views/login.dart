import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: const AssetImage('assets/logo.webp'),
                    backgroundColor: Colors.grey.shade300,
                    radius: 70,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4, // Ajustement
            left: 0,
            right: 0,
            child: Container(
              height:
                  MediaQuery.of(context).size.height, // Hauteur ajustée
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Authentification',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Authentifiez-vous pour sauvegarder et recuperer votre progression.',
                          style: TextStyle(
                              fontSize: 15, color: Colors.black,
                              ),textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 8.0,
                        minimumSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      onPressed: (){}, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.facebook, color: Colors.white, size: 25,),
                          const Text('Se connecter avec facebook', style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          ),)],
                      ),
                      ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 8.0,
                        minimumSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      onPressed: (){}, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.google, color: Colors.red, size: 25,),
                          const Text('Se connecter avec google', style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15 
                          ),)],
                      ),
                      ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 64, 41, 41),
                        elevation: 8.0,
                        minimumSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      onPressed: (){}, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.github, color: Colors.white, size: 25,),
                          const Text('Se connecter avec github', style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          ),)],
                      ),
                      ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 8.0,
                        minimumSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      onPressed: (){}, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.apple, color: Colors.white, size: 25,),
                          const Text('Se connecter avec apple', style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          ),)],
                      ),
                      ),
                   ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}