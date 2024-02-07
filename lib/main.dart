import 'package:code_crafters/firebase_options.dart';
import 'package:code_crafters/services/authentification.dart';
import 'package:code_crafters/views/parcoursViews/parcours.dart';
import 'package:code_crafters/views/widgets/onBoarding_screen.dart';
import 'package:code_crafters/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
runApp(MultiProvider(
    providers: [
      StreamProvider.value(value: AuthService().user, initialData: null),
    ],
    child: MyApp(),
  ));
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
        '/':(context) => Wrapper(),
        '/parcours':(context) => CourseProgressScreen()
      },
    
    );
  }
}
