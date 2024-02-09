import 'package:flutter/material.dart';

class Module1View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data to represent chapter unlock status
    bool chapter1Unlocked = true;
    bool chapter2Unlocked = false;
    bool chapter3Unlocked = false;
    bool chapter4Unlocked = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Module 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Chapter 1
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: chapter1Unlocked ? Colors.green : Colors.red,
              ),
              child: Icon(
                chapter1Unlocked ? Icons.play_arrow : Icons.lock,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
            ),
            // Line connecting Chapter 1 and Chapter 2
            SizedBox(height: 50),
            CustomPaint(
              size: Size(30, 100),
              painter: LinePainter(),
            ),
            // Chapter 2
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: chapter2Unlocked ? Colors.green : Colors.red,
              ),
              child: Icon(
                chapter2Unlocked ? Icons.play_arrow : Icons.lock,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
            ),
            // Line connecting Chapter 2 and Chapter 3
            SizedBox(height: 50),
            CustomPaint(
              size: Size(30, 100),
              painter: LinePainter(),
            ),
            // Chapter 3
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: chapter3Unlocked ? Colors.green : Colors.red,
              ),
              child: Icon(
                chapter3Unlocked ? Icons.play_arrow : Icons.lock,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
            ),
            // Line connecting Chapter 3 and Chapter 4
            SizedBox(height: 50),
            CustomPaint(
              size: Size(30, 100),
              painter: LinePainter(),
            ),
            // Chapter 4
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: chapter4Unlocked ? Colors.green : Colors.red,
              ),
              child: Icon(
                chapter4Unlocked ? Icons.play_arrow : Icons.lock,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter to draw lines between chapters
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
