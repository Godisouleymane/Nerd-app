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
          height: 200.0,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: widget.isSelected
                  ? widget.selectedBorderColor
                  : widget.defaultBorderColor,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.containerIcon != null) widget.containerIcon!,
                Text(
                  'Container ${widget.containerId}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Autre Information : ${widget.autreInformation}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Autre Variable : ${widget.autreVariable}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
