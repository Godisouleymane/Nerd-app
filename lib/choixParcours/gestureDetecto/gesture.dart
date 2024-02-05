import 'package:flutter/material.dart';

class CustomGestureDetector extends StatefulWidget {
  final String containerId;
  final Color defaultBorderColor;
  final Color selectedBorderColor;
  final Function(String) onTapCallback;
  final Icon? containerIcon;

  const CustomGestureDetector({
    required this.containerId,
    required this.defaultBorderColor,
    required this.selectedBorderColor,
    required this.onTapCallback,
    this.containerIcon,
  });

  @override
  _CustomGestureDetectorState createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
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
          border: Border.all(
            color: widget.containerId == widget.containerId
                ? widget.selectedBorderColor
                : widget.defaultBorderColor,
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            if (widget.containerIcon != null) widget.containerIcon!,
            Text(
              'Container ${widget.containerId}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
