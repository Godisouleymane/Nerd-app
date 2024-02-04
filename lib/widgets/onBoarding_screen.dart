import 'package:code_mentor/widgets/intro_screen/page1.dart';
import 'package:code_mentor/widgets/intro_screen/page2.dart';
import 'package:code_mentor/widgets/intro_screen/page3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
        children: const [
         introPage1(),
         introPage2(),
         introPage3(),
        ],
      ),

      Container(
        alignment: Alignment(0, 0.75),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _controller.nextPage(duration: 
                Duration(milliseconds: 500), 
                curve: Curves.easeIn);
              },
              child: Text('Passer'),
              ),


            SmoothPageIndicator(
              controller: _controller, 
              count: 3),

              GestureDetector(
                onTap: () {
                _controller.nextPage(duration: 
                Duration(milliseconds: 500), 
                curve: Curves.easeIn);
              },
                child: Text('Suivant')
                ),
          ],
        ),
      )
        ],
      )
    );
  }
}