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
                    color:  Color.fromARGB(255, 53, 32, 149),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(23),
                        bottomRight: Radius.circular(23))),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(user!.photoURL!)),
                    const Gap(5),
                    Text(
                      user.displayName!,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '12 peers',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ))),
                const Gap(25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Learning Contribution',
                style: TextStyle(
                  fontSize: 15,
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
                padding: EdgeInsets.all(8.0),
                child: Text("Parametre de l'app", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                )
                ),
              ),
              const Card(
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: Text('Langue de l\'application'),
                      trailing: Icon(Icons.flag_circle, color: Colors.blue,),
                    ),
                    ListTile(
                      dense: true,
                      title: Text('Theme de l\'application'),
                      trailing: Icon(Icons.sunny, color: Colors.amber,),
                    ),
                    ListTile(
                      dense: true,
                      title: Text('Feedback'),
                      trailing: Icon(Icons.feedback, color: Colors.green,),
                    ),
                    ListTile(
                      dense: true,
                      title: Text('Nous suivres'),
                      trailing: Icon(Icons.favorite, color: Colors.red,),
                    ),
                    ListTile(
                      dense: true,
                      title: Text('Inviter un peer'),
                      trailing: Icon(Icons.family_restroom,),
                    ),
                  ],
                )
              )
          ],
        ),
      ),
    );
  }
}
