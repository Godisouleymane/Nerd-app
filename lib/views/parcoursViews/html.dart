import 'package:code_crafters/views/parcoursViews/shared-ui/bottomNaviagtionBar.dart';
import 'package:flutter/material.dart';

class HTMLView extends StatefulWidget {
  const HTMLView({super.key});

  @override
  State<HTMLView> createState() => _HTMLViewState();
}

class _HTMLViewState extends State<HTMLView> {
  @override
  Widget build(BuildContext context) {
    return BottomNaviBar();
  }
}
