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
   
    return GestureDetector(
      onTap: () {
        widget.onTapCallback(widget.containerId);
      },
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            color: widget.isSelected
                ? widget.selectedBorderColor
                : widget.defaultBorderColor,
            width: 2.0,
          ),
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
    );
  }
}
