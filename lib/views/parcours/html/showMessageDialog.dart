import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_crafters/models/discussionModel.dart';
import 'package:code_crafters/models/messageModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageDialog {
  void showMessDialog(BuildContext context) {
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
                          value!.isEmpty ? _formErreurSujet : null,
                      decoration: const InputDecoration(
                        labelText: "Mettez votre sujet",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Form(
                    key: _keyFormMessage,
                    child: TextFormField(
                      maxLength: 100,
                      onChanged: (value) => _messageDesc = value,
                      validator: (value) => value!.isEmpty ? _formErreur : null,
                      decoration: const InputDecoration(
                        labelText: "Mettez votre message ici",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('ANNULER'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_keyFormSujet.currentState!.validate() &&
                                _keyFormMessage.currentState!.validate()) {
                              // Récupérer les valeurs saisies par l'utilisateur pour le sujet et le message
                              String sujet = _sujetText;
                              String message = _messageDesc;

                              // Appeler la fonction _lancerDiscussion avec les valeurs saisies
                              _lancerDiscussion(sujet, message);

                              // Fermer le dialogue après avoir lancé la discussion
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('LANCER'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _lancerDiscussion(String sujet, String message) {
    // Vérifier si l'utilisateur est authentifié
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("Utilisateur authentifié.");
      return;
    }

    // Référence à la collection discussions
    CollectionReference discussionsRef =
        FirebaseFirestore.instance.collection('discussions');

    // Nouvel objet discussion
    String discussionId = discussionsRef.doc().id;
    Discussion nouvelDiscussion = Discussion(
      id: discussionId,
      sujet: sujet,
      photoUrl: user.photoURL!,
      createurID: user.uid,
      heureCreation: DateTime.now(),
    );

    // Enregistrer la nouvelle discussion dans Firestore
    discussionsRef.doc(discussionId).set({
      'sujet': nouvelDiscussion.sujet,
      'createurId': nouvelDiscussion.createurID,
      'photoUrl': nouvelDiscussion.photoUrl,
      'heureCreation': nouvelDiscussion.heureCreation,
    }).then((_) {
      print('Discussion enregistrée avec succès.');

      // La discussion est enregistrée avec succès, ajoutons le premier message
      CollectionReference messagesRef = FirebaseFirestore.instance
          .collection('discussions/$discussionId/messages');

      // Nouvel identifiant unique pour le premier message
      String premierMessageId = messagesRef.doc().id;

      // Nouvel objet pour le message
      Message premierMessage = Message(
        id: premierMessageId,
        discussionId: discussionId,
        contenu: message,
        photoUrl: user.photoURL!,
        auteurId: user.uid,
        heureEnvoi: DateTime.now(),
      );

      // Enregistrer le premier message dans Firestore
      messagesRef.doc(premierMessageId).set({
        'discussionId': premierMessage.discussionId,
        'contenu': premierMessage.contenu,
        'auteurId': premierMessage.auteurId,
        'heureEnvoi': premierMessage.heureEnvoi,
        'photoUrl': premierMessage.photoUrl,
      }).then((_) {
        print('Premier message enregistré avec succès.');
        // Naviguer vers la discussion nouvellement créée
      }).catchError((error) {
        print("Erreur lors de l'enregistrement du premier message: $error");
      });
    }).catchError((error) {
      print("Erreur lors de l'enregistrement de la discussion: $error");
    });
  }
}
