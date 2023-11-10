import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class FirebaseHome extends StatelessWidget {
  const FirebaseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Color.fromARGB(255, 0, 123, 224)),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final FirebaseAuth fa = FirebaseAuth.instance;
              final User? currentUser = fa.currentUser;
              final email = currentUser?.email;
              final password = currentUser?.uid;
              final emailVerified = currentUser?.emailVerified??false;
              if(emailVerified)
                print("Your Email Is Verified");
              else {
                print("Please verify email address");
              }
              return const Text('Done');
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
