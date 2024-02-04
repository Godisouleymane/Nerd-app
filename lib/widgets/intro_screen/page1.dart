import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class introPage1 extends StatelessWidget {
  const introPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            child: SvgPicture.asset(
            "assets/programmer-animate.svg",
            ),
          ),
        )
      ],
    );
  }
}