import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_crafters/views/widgets/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../widgets/AlertDialog.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cours')
          .doc('html_cours')
          .collection('modules')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Quelque chose s\'est mal passé'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Lottie.asset('assets/bulleLoading.json'));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
              child: GestureDetector(
                onTap: () {
                  print("ID du module: ${data['id']}");
                  data['estDebloquer']
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CoursDetailScreen(moduleId: data['id']),
                          ),
                        )
                      : showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Module non débloqué'),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Desolé ce module est bloqué'),
                                    Text(
                                        'Veuillez finir le module précédent pour debloquer celui-ci'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Fermer'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        spreadRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/vector.png'),
                      const SizedBox(height: 8),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['titre'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  data['estDebloquer']
                                      ? Icons.play_arrow
                                      : Icons.lock,
                                  size: 35,
                                  color: data['estDebloquer']
                                      ? const Color.fromARGB(255, 7, 255, 16)
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class CoursDetailScreen extends StatelessWidget {
  final String moduleId;

  const CoursDetailScreen({Key? key, required this.moduleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Identifiant du module : $moduleId");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Leçons du Module',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('cours')
                .doc('html_cours')
                .collection('modules')
                .doc(moduleId)
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(color: Colors.teal);
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(
                  child: Text('Erreur lors de la récupération des données'),
                );
              }

              final data = snapshot.data!.data() as Map<String, dynamic>;
              final videoUrl = data['videoUrl'] ?? '';

              return Container(
                color: Colors.teal,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.22,
                child: VideoPlayerWidget(videoUrl: videoUrl),
              );
            },
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('cours')
                    .doc('html_cours')
                    .collection('modules')
                    .doc(moduleId)
                    .collection('lecons')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Une erreur s\'est produite : ${snapshot.error}',
                      ),
                    );
                  }

                  final lessons = snapshot.data!.docs;
                  print(lessons);
                  return ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lessonData =
                          lessons[index].data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          if (lessonData['estDebloquer']) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LessonScreen(
                                  moduleId: moduleId,
                                  lessonId: lessonData['id'],
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (
                                BuildContext context,
                              ) {
                                return AlertDialog(
                                  title: const Text('Leçon Bloquée'),
                                  content: const SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text('Désolé cette leçon est bloquée'),
                                        Text(
                                            'Veuillez finir la leçon précédente pour débloquer celle-ci'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Fermer'),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: ListTile(
                          title: Text(
                            lessonData['titre'] ?? 'Titre inconnu',
                          ),
                          leading: const Icon(Icons.book),
                          trailing: lessonData['estDebloquer']
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.lock),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LessonScreen extends StatefulWidget {
  final moduleId;
  final lessonId;
  const LessonScreen(
      {super.key, required this.moduleId, required this.lessonId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List<Map<String, dynamic>> _sections = [];
  int _currentSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchSections();
    _updateUserProgress();
  }

  Future<void> _fetchSections() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cours')
        .doc('html_cours')
        .collection('modules')
        .doc(widget.moduleId)
        .collection('lecons')
        .doc(widget.lessonId)
        .collection('sections')
        .get();
    setState(() {
      _sections = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _updateUserProgress() async {
    // recuperer l'id de l'utilisateur
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null; // verifier si l'utilisateur est connecté

    // Mettre a jour la progression de l'utilisateur dans firestore
    await FirebaseFirestore.instance
        .collection('progressionUtilisateurs')
        .doc(user.uid)
        .collection('coursEnCours')
        .doc('html')
        .update({
      'leçonActuelle': widget.lessonId,
    });
  }

  Future<void> _completeLesson() async {
    // Mettre la leçon actuelle comme terminee
    await FirebaseFirestore.instance
        .collection('cours')
        .doc('html_cours')
        .collection('modules')
        .doc(widget.moduleId)
        .collection('lecons')
        .doc(widget.lessonId)
        .update({'estTerminee': true});

    // recuperer l'id de la leçon suivante
    final nextLesson = await _getNextLessonId();
    if (nextLesson != null) {
      // Debloquer la leçon suivante
      await FirebaseFirestore.instance
          .collection('cours')
          .doc('html_cours')
          .collection('modules')
          .doc(widget.moduleId)
          .collection('lecons')
          .doc(nextLesson)
          .update({
            'estDebloquer' : true
          });
    }

    
  }

  void _continueLesson() {
    setState(() {
      if (_currentSectionIndex < _sections.length - 1) {
        _currentSectionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sections == null || _sections.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chargement des sections')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final currentSection = _sections[_currentSectionIndex];
    final totalSections = _sections.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(currentSection['titre'] ?? 'Titre inconnu'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.flag_outlined))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LinearProgressIndicator(
            value: (_currentSectionIndex + 1),
            minHeight: 15,
            color: Colors.grey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentSection['contenu'] ?? 'Contenu non disponible',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: _continueLesson,
          child: Text(
            _currentSectionIndex == totalSections - 1
                ? 'Terminer'
                : 'Continuer',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    _controller = VideoPlayerController.network(widget.videoUrl);
    try {
      await _controller.initialize();
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: false,
          looping: false,
        );
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      print('Error initializing video: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _isError
            ? const Center(
                child: Text('Erreur lors du chargement de la vidéo'),
              )
            : _chewieController != null &&
                    _chewieController.videoPlayerController.value.isInitialized
                ? Chewie(
                    controller: _chewieController,
                  )
                : Container(
                    color: Colors.white,
                  ); // Afficher un conteneur vide si Chewie n'est pas initialisé
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
