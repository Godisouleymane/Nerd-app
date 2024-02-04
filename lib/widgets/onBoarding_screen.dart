import 'package:code_mentor/widgets/home_page.dart';
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

   bool onLastPage = false;

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
        alignment: Alignment(0, 0.80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _controller.jumpToPage(2);
              },
              child: const Text('Passer', style: TextStyle(
                fontWeight: FontWeight.bold,
               fontSize: 15,
                 color: Colors.orange
              ),),
              ),


            SmoothPageIndicator(
              effect: WormEffect(
                dotColor: Colors.grey.shade300,
                activeDotColor: Colors.orange
              ),
              controller: _controller, 
              count: 3),

              onLastPage ?
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: 
             (){}, 
             child: Icon(
              Icons.arrow_forward, color: Colors.white,)
              ) :
                  GestureDetector(
                onTap: () {
                _controller.nextPage(duration: 
                Duration(milliseconds: 500), 
                curve: Curves.easeIn);
              },
                child: const Text('Suivant', style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 15,
                     color: Colors.orange
                ),)
                ),
          ],
        ),
      )
        ],
      )
    );
  }
}