import 'package:code_crafters/Cours_data/Les_Cours.dart';
import 'package:code_crafters/firebase_options.dart';
import 'package:code_crafters/provider/cours_model.dart';
import 'package:code_crafters/views/parcours/html/html.dart';
import 'package:code_crafters/views/profile/profile.dart';
import 'package:code_crafters/views/widgets/onBoarding_screen.dart';
import 'package:code_crafters/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  addCourseToFireStore();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContainerSelectionModel(),
        ),
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CodeCrafters',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Wrapper(),
        '/html': (context) => const HTMLView(),
        '/profile':(context) => const ProfileScreen(),
        '/onBoading_screen':(context) => const OnBoardingScreen(),
      },
    );
  }
}
