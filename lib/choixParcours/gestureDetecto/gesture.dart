import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomGestureDetector extends StatefulWidget {
  final String containerId;
  final Color defaultBorderColor;
  final Color selectedBorderColor;
  final Function(String) onTapCallback;
  final Icon? containerIcon;
  final String autreInformation;
  final String autreVariable;
  final bool isSelected; // Ajout de la variable isSelected
  final double width;
  final BoxDecoration? decoration;
  final bool hasImage;

  const CustomGestureDetector({
    required this.containerId,
    required this.defaultBorderColor,
    required this.selectedBorderColor,
    required this.onTapCallback,
    this.containerIcon,
    required this.autreInformation,
    required this.autreVariable,
    this.isSelected = false, // Initialisation de la variable isSelected
    this.width = 250,
    this.decoration,
    this.hasImage = false,
    Key? key,
  }) : super(key: key);
  @override
  _CustomGestureDetectorState createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  bool isSelected = false;
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          widget.onTapCallback(widget.containerId);
        },
        child: Container(
          width: widget.width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(137, 255, 255, 255),
            border: Border.all(
              color: widget.isSelected
                  ? widget.selectedBorderColor
                  : widget.defaultBorderColor,
              width: 4.0,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.hasImage)
               SvgPicture.asset('assets/fullStack.svg',fit: BoxFit.cover, height: 300,),
              if (widget.containerIcon != null) widget.containerIcon!,
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.autreInformation,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.autreVariable,
                    style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
