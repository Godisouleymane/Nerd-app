import 'package:flutter/material.dart';

class CustomGestureDetector extends StatefulWidget {
  final String containerId;
  final Color defaultBorderColor;
  final Color selectedBorderColor;
  final Function(String) onTapCallback;
  final Icon? containerIcon;
  final String autreInformation;
  final String autreVariable;
  final bool isSelected; // Ajout de la variable isSelected

  const CustomGestureDetector({
    required this.containerId,
    required this.defaultBorderColor,
    required this.selectedBorderColor,
    required this.onTapCallback,
    this.containerIcon,
    required this.autreInformation,
    required this.autreVariable,
    this.isSelected = false, // Initialisation de la variable isSelected
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
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(
              color: widget.isSelected
                  ? widget.selectedBorderColor
                  : widget.defaultBorderColor,
              width: 4.0,
            ),
            borderRadius: BorderRadius.circular(10),
             boxShadow: const [
              BoxShadow(
                color:  Colors.black,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.containerIcon != null) widget.containerIcon!,
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                     widget.autreInformation,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                        )
                        ,textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0, top: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.autreVariable,
                      style: TextStyle(
                        color: Colors.white,
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
