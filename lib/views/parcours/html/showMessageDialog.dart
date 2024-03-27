import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageDialog {
  // Fonction pour visualiser la boite de dialogue
  void showMessDialog(
    BuildContext context,
  ) {
    final _keyFormSujet = GlobalKey<FormState>();
    final _keyFormMessage = GlobalKey<FormState>();
    String _messageDesc = '';
    String _sujetText = '';
    String _formErreur = 'Veuillez ajouter un message';
    String _formErreurSujet = 'Veuillez fournir le sujet de la discussion';

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            elevation: 10,
            contentPadding: const EdgeInsets.all(10),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                        key: _keyFormSujet,
                        child: TextFormField(
                          maxLength: 100,
                          onChanged: (value) => _sujetText = value,
                          validator: (value) =>
                              _sujetText.isEmpty ? _formErreurSujet : null,
                          decoration: const InputDecoration(
                            labelText: "Mettez votre sujet",
                            border: OutlineInputBorder(),
                          ),
                        )),
                    Form(
                        key: _keyFormMessage,
                        child: TextFormField(
                          maxLength: 100,
                          onChanged: (value) => _messageDesc = value,
                          validator: (value) =>
                              _messageDesc.isEmpty ? _formErreur : null,
                          decoration: const InputDecoration(
                            labelText: "Mettez votre message ici",
                            border: OutlineInputBorder(),
                          ),
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('ANNULER')),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('LANCER')),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}
