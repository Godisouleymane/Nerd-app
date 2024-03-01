import 'package:code_crafters/services/authentification.dart';
import 'package:code_crafters/views/profile/heatMap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 32, 149),
        title: const Text('Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 53, 32, 149),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(26),
                        bottomRight: Radius.circular(26))),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(user!.photoURL!)),
                    const Gap(10),
                    Text(
                      user.displayName!,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '0 peers',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ))),
            const Gap(25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Learning Contribution',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(10),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: MyHeatMap(),
            ),
            const Gap(20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text("Parametre de l'app",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        dense: true,
                        title: Text(
                          'Langue de l\'application',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(
                          Icons.flag_circle,
                          color: Colors.blue,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('Theme de l\'application',
                            style: TextStyle(fontSize: 14)),
                        trailing: Icon(
                          Icons.sunny,
                          color: Colors.amber,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('Feedback', style: TextStyle(fontSize: 14)),
                        trailing: Icon(
                          Icons.feedback,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('Nous suivres',
                            style: TextStyle(fontSize: 14)),
                        trailing: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('Inviter un peer',
                            style: TextStyle(fontSize: 14)),
                        trailing: Icon(
                          Icons.family_restroom,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('Partager mon profile',
                            style: TextStyle(fontSize: 14)),
                        trailing: Icon(
                          Icons.share, color: Colors.grey,
                        ),
                      ),
                    ],
                  )),
            ),
            const Gap(40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text('Zone Risquée',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue, width: 3.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size(MediaQuery.of(context).size.width, 55)),
                  onPressed: () => signOut(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Se deconnecter',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Gap(4),
                      Icon(
                        Icons.logout,
                        color: Colors.blue,
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 8.0, left: 8.0, bottom: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red, width: 3.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size(MediaQuery.of(context).size.width, 55)),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Supprimer mon compte',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Gap(4),
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  signOut(BuildContext context) {
    Navigator.pushNamed(context, '/onBoading_screen');
    AuthService().signOut();
  }
}
