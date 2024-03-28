import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_crafters/models/discussionModel.dart';
import 'package:code_crafters/models/messageModel.dart';
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

  void _lancerDiscussion(String sujet, String message) {
    // reference a la collection discussion
    CollectionReference discussionsRef =
        FirebaseFirestore.instance.collection('discussions');

    // Nouvel objet discussion
    String discussionId = discussionsRef.doc().id;
    Discussion nouvelDiscussion = Discussion(
        id: discussionId,
        sujet: sujet,
        createurID: FirebaseAuth
            .instance.currentUser!.uid, // l'id de l'utilisateur actuel
        heureCreation: DateTime.now());

    // Enregistrer la nouvelle discussion dans firestore
    discussionsRef.doc(discussionId).set({
      'sujet': nouvelDiscussion.sujet,
      'createurId': nouvelDiscussion.createurID,
      'heureCreation': nouvelDiscussion.heureCreation
    }).then((_) {
      // la discussion est enregistrée avec succès, ajoutons le premier message
      CollectionReference messagesRef = FirebaseFirestore.instance
          .collection('discussions/$discussionId/messages');

      // Créez un nouvel identifiant unique pour le premier message
      String premierMessageId = messagesRef.doc().id;

      // Nouvel objet pour le message
      Message premierMessage = Message(
          id: premierMessageId,
          discussionId: discussionId,
          contenu: message,
          auteurId: FirebaseAuth.instance.currentUser!.uid,
          heureEnvoi: DateTime.now());

      // Enregistrer le premier message dans firestore
      messagesRef.doc(premierMessageId).set({
        'discussionId': premierMessage.discussionId,
        'contenu': premierMessage.contenu,
        'auteurId': premierMessage.auteurId,
        'heureEnvoi': premierMessage.heureEnvoi,
      }).then((_) {
        // Le premier message est enregistré avec succès
        // naviguer vers la discussion nouvellement créée
      }).catchError((error) {
        // Gérez les erreurs lors de l'enregistrement du premier message
        print("Erreur lors de l'enregistrement du premier message: $error");
      });
    }).catchError((error) {
      // Gérez les erreurs lors de l'enregistrement de la discussion
      print("Erreur lors de l'enregistrement de la discussion: $error");
    });
    ;
  }
}
