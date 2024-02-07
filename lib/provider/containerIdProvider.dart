import 'package:flutter/material.dart';

class SelectedContainerIdProvider extends ChangeNotifier {
  String? _selectedContainerId;

  String? get selectedContainerId => _selectedContainerId;

  void setSelectedContainerId(String id) {
    _selectedContainerId = id;
    notifyListeners();
  }
}
