import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<IconData> icons;
  final List<String> labels;
  final List<Color>
      selectedColors; 
  final List<Color>
      unselectedColors; 

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
    required this.labels,
    required this.selectedColors,
    required this.unselectedColors,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      icons.length == labels.length &&
          icons.length == selectedColors.length &&
          icons.length == unselectedColors.length,
      'The number of icons, labels, selectedColors, and unselectedColors must be the same.',
    );

    List<Widget> navBarItems = List.generate(icons.length, (index) {
      return Icon(icons[index],
          color: currentIndex == index
              ? selectedColors[index]
              : unselectedColors[index]);
    });

    return CurvedNavigationBar(
      animationDuration: Duration(milliseconds: 300),
      color: Colors.teal,
      backgroundColor: Colors.white,
      items: navBarItems,
      index: currentIndex,
      onTap: onTap,
    );
  }
}
