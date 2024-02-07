import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget {
  final String titre;

  const MyAppBar({Key? key, required this.titre}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  static void updateAppBarTitle(BuildContext context, String newTitle) {
    final _MyAppBarState? state =
        context.findAncestorStateOfType<_MyAppBarState>();
    if (state != null) {
      state.updateTitle(newTitle);
    }
  }
}

class _MyAppBarState extends State<MyAppBar> {
  String _titre = '';

  @override
  void initState() {
    super.initState();
    _titre = widget.titre;
  }

  // Fonction pour mettre à jour le titre de l'AppBar
  void updateTitle(String newTitle) {
    setState(() {
      _titre = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return AppBar(
      title: Text(_titre),
       actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(_user!.photoURL!),
          ),
        )
      ],
    );
  }
}
