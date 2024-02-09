import 'package:flutter/material.dart';

class ScreenHtml extends StatefulWidget {
  const ScreenHtml({Key? key}) : super(key: key);

  @override
  State<ScreenHtml> createState() => _ScreenHtmlState();
}

class _ScreenHtmlState extends State<ScreenHtml> {
  late CourseModule _selectedModule;

  final List<CourseModule> _courseModules = [
    CourseModule(
      moduleName: 'Module 1: Introduction à HTML',
      isUnlocked: true,
      courses: const [
        'Comprendre les bases du HTML',
        'Structure d\'une page HTML',
        'Les éléments et balises HTML les plus courants',
        'Syntaxe de base HTML',
        'Exercice fin du module'
      ],
      courseUnlockedStatus: [true, false, false, false, false],
    ),
    CourseModule(
      moduleName: 'Module 2: Structure et Sémantique',
      isUnlocked: false,
      courses: [
        "Utilisation des éléments sémantiques HTML5 (header, footer, nav, section, article, etc.)",
        "Importance de la sémantique dans le référencement et l'accessibilité",
        "Exercice fin du module",
      ],
      courseUnlockedStatus: [true, false, false, false],
    ),
    CourseModule(
      moduleName: 'Module 3: Liens, Images et Médias',
      isUnlocked: false,
      courses: ["Création de liens hypertextes", 
      "Intégration d'images dans une page HTML",
      "Utilisation de balises pour l'audio et la vidéo",
      "Exercice fin du module"
      ],
      courseUnlockedStatus: [true, false, false, false],
    ),
    CourseModule(
      moduleName: 'Module 4: Formulaires',
      isUnlocked: false,
      courses: [
        "Création de formulaires HTML",
        "Utilisation de différents types de champs de formulaire (texte, e-mail, mot de passe, etc.)",
        "Exercice fin du module"
      ],
      courseUnlockedStatus: [true, false, false, false],
    ),
    CourseModule(
      moduleName: 'Module 5: Bonnes Pratiques et Normes',
      isUnlocked: false,
      courses: [
        "Les meilleures pratiques pour le codage HTML",
        "Validation HTML et accessibilité",
        "Exercice fin module"
      ],
      courseUnlockedStatus: [true, false, false, false],
    ),
  ];

  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedModule = _courseModules.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _showModulesBottomSheet(context);
                },
                child: Container(
                  key: _containerKey,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.list,
                        size: 30,
                      ),
                      Flexible(
                        child: Text(
                          _selectedModule.moduleName,
                          softWrap: true,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 53, 32, 149),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_selectedModule ==
                  _courseModules
                      .first) // Display chapters only if module 1 is selected
                SizedBox(height: 20),
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 300),
                painter: ChapterDiagramPainter(
                  _selectedModule.courses.length,
                  _containerKey,
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _selectedModule.courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    final course = _selectedModule.courses[index];
                    final bool isUnlocked =
                        _selectedModule.courseUnlockedStatus[index];

                    return Column(
                      children: [
                        SizedBox(height: 40),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              isUnlocked
                                  ? Icon(Icons.play_arrow, color: Colors.green)
                                  : Icon(Icons.lock, color: Colors.red),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  course,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isUnlocked ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModulesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _courseModules.length,
          itemBuilder: (BuildContext context, int index) {
            final courseModule = _courseModules[index];
            final isSelected = courseModule == _selectedModule;
            final textStyle = TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            );
            final tileColor = isSelected ? Colors.deepPurple : null;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                shadowColor: Colors.grey,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Text(
                    courseModule.moduleName,
                    style: textStyle,
                  ),
                  tileColor: tileColor,
                  onTap: () {
                    if (courseModule.isUnlocked) {
                      setState(() {
                        _selectedModule = courseModule;
                      });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Veuillez terminer le module précédent pour déverrouiller celui-ci.'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CourseModule {
  final String moduleName;
  bool isUnlocked;
  final List<String> courses;
  final List<bool> courseUnlockedStatus;

  CourseModule({
    required this.moduleName,
    required this.isUnlocked,
    required this.courses,
    required this.courseUnlockedStatus,
  });
}

class ChapterDiagramPainter extends CustomPainter {
  final int numberOfChapters;
  final double verticalSpacing = 150.0;
  final GlobalKey containerKey;

  ChapterDiagramPainter(this.numberOfChapters, this.containerKey);

  @override
  void paint(Canvas canvas, Size size) {
    final RenderBox containerRenderBox =
        containerKey.currentContext!.findRenderObject() as RenderBox;
    final Offset containerOffset =
        containerRenderBox.localToGlobal(Offset.zero);

    final double startX = size.width / 2;
    final double startY = containerOffset.dy;
    final double endY = size.height - 20;

    final double totalVerticalSpace = verticalSpacing * (numberOfChapters - 1);
    final double spaceBetweenChapters =
        (endY - startY - totalVerticalSpace) / (numberOfChapters - 1);
    final double stepY = spaceBetweenChapters + verticalSpacing;

    final Paint paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 3;

    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), paint);

    double currentY = startY;
    for (int i = 0; i < numberOfChapters; i++) {
      canvas.drawLine(Offset(startX, currentY),
          Offset(startX, currentY + spaceBetweenChapters), paint);
      currentY += stepY;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
