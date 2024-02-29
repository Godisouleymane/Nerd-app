import 'package:code_crafters/services/authentification.dart';
import 'package:code_crafters/services/userProgression.dart';
import 'package:code_crafters/views/widgets/intro_screen/page1.dart';
import 'package:code_crafters/views/widgets/intro_screen/page2.dart';
import 'package:code_crafters/views/widgets/intro_screen/page3.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;
  bool inLoginProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            introPage1(),
            introPage2(),
            introPage3(),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _controller.jumpToPage(2);
                },
                child: const Text(
                  'Passer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(255, 53, 32, 149)),
                ),
              ),
              SmoothPageIndicator(
                  effect: WormEffect(
                      dotColor: Colors.grey.shade300,
                      activeDotColor: const Color.fromARGB(255, 53, 32, 149)),
                  controller: _controller,
                  count: 3),
              onLastPage
                  ? inLoginProcess
                      ? Container(child: const CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 53, 32, 149),
                          ),
                          onPressed: () => signIn(),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ))
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: const Text(
                        'Suivant',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 53, 32, 149)),
                      )),
            ],
          ),
        )
      ],
    ));
  }

  signIn() async {
    setState(() {
      inLoginProcess = true;
    });

    try {
      await AuthService().signInWithGoogle();
      // Une fois la connexion réussie, naviguer vers la page suivante ou la page d'accueil
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroductionPage()),
      );
      initializeHTMLCourseProgressForUser();
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
