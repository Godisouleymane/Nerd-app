import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<Widget> screens;
  final ValueChanged<int> onTap;
  final List<IconData> icons;
  final List<String> labels;
  final List<Color> selectedColors;
  final List<Color> unselectedColors;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.screens,
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

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: List.generate(
        icons.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(icons[index]),
          label: labels[index],
          backgroundColor: Colors.transparent,
        ),
      ),
      selectedItemColor: selectedColors[currentIndex],
      unselectedItemColor: unselectedColors[currentIndex],
    );
  }
}
