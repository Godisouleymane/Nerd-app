import 'package:code_crafters/services/authentification.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool inLoginProcess = false;
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
                    child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3, color: Colors.black, spreadRadius: 3)
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 70.0,
                    backgroundImage: AssetImage('assets/logo.webp'),
                  ),
                )),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4, 
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height, 
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
                      padding: EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Authentifiez-vous pour sauvegarder et recuperer votre progression.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 8.0,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.facebook,
                              color: Colors.white,
                              size: 25,
                            ),
                            const Text(
                              'Se connecter avec facebook',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: inLoginProcess ? const CircularProgressIndicator(color: Colors.red,) :
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 8.0,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed:() => signIn(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.google,
                              color: Colors.red,
                              size: 25,
                            ),
                            const Text(
                              'Se connecter avec google',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 64, 41, 41),
                            elevation: 8.0,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.github,
                              color: Colors.white,
                              size: 25,
                            ),
                            const Text(
                              'Se connecter avec github',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 8.0,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.apple,
                              color: Colors.white,
                              size: 25,
                            ),
                            const Text(
                              'Se connecter avec apple',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
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

  signIn() async {
    setState(() {
      inLoginProcess = true;
    });

    try {
      await AuthService().signInWithGoogle();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroductionPage()),
      );
    } catch (e) {
      // Gérer les erreurs ici
      print("Erreur lors de la connexion avec Google : $e");
      // Affichez un message à l'utilisateur pour l'informer de l'erreur, si nécessaire
    } finally {
      setState(() {
        inLoginProcess = false;
      });
    }
  }
}
