import 'package:flutter/material.dart';

class ContainerSelectionModel extends ChangeNotifier {
  String _selectedContainerId = '';

  String get selectedContainerId => _selectedContainerId;

  void updateSelectedContainer(String id) {
    _selectedContainerId = id;
    notifyListeners();
  }
}
