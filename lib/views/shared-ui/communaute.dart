import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:code_crafters/views/parcours/html/showMessageDialog.dart';
import 'package:gap/gap.dart';

class Communaute extends StatelessWidget {
  final User? user;
  const Communaute({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('discussions')
                  .orderBy('heureCreation', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Aucune discussion trouvée'),
                  );
                }
                final discussions = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: discussions.length,
                  itemBuilder: (context, index) {
                    final discussion = discussions[index];
                    final sujet = discussion['sujet'];
                    final heureCreation = discussion['heureCreation'];
                    final photoUrl = discussion['photoUrl'];
                    final discussionId = discussion.id;
                    // Accéder à la sous-collection des messages
                    CollectionReference messagesRef = FirebaseFirestore.instance
                        .collection('discussions/${discussion.id}/messages');
                    return StreamBuilder(
                      stream: messagesRef.orderBy('heureEnvoi').snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> messageSnapshot) {
                        if (messageSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (!messageSnapshot.hasData) {
                          return const Text('Pas de messages');
                        }
                        final messages = messageSnapshot.data!.docs;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DiscussionDetailPage(
                                  discussionId: discussionId,
                                  discussionSujet: sujet,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Card(
                                  color: Colors.grey.shade50,
                                  child: ListTile(
                                    isThreeLine: true,
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(photoUrl),
                                    ),
                                    title: Text(
                                      sujet,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    subtitle: Text(messages.isNotEmpty
                                        ? messages.last['contenu']
                                        : ''),
                                    trailing: Text(
                                      // Formater la date et l'heure de création de la discussion
                                      '${heureCreation.toDate().day}/${heureCreation.toDate().month}/${heureCreation.toDate().year} ${heureCreation.toDate().hour}:${heureCreation.toDate().minute}',
                                    ),
                                  ),
                                ),
                              ),
                              Gap(10)
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => MessageDialog().showMessDialog(context),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}

class DiscussionDetailPage extends StatelessWidget {
  final String discussionId;
  final String discussionSujet;

  const DiscussionDetailPage(
      {required this.discussionId, required this.discussionSujet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          discussionSujet,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('discussions/$discussionId/messages')
                  .orderBy('heureEnvoi', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Aucun message trouvé'),
                  );
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final contenu = message['contenu'];
                    final heureEnvoi = message['heureEnvoi'];
                    final photoUrl = message['photoUrl'];
                    return ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(photoUrl),
                      ),
                      trailing: const Icon(Icons.more_horiz_outlined),
                      title: Text(contenu),
                      subtitle: Text(
                        '${heureEnvoi.toDate().day}/${heureEnvoi.toDate().month}/${heureEnvoi.toDate().year} ${heureEnvoi.toDate().hour}:${heureEnvoi.toDate().minute}',
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Taper votre message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Ajoutez ici la logique pour envoyer le message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
