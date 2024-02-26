import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(_user!.photoURL!),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text(_user!.displayName!,style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ],
                  ),
                ),  
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Activités', style: TextStyle(
                 fontSize: 18
              ),),
            )
          ],
        ),
        
      ),
    );
  }
}