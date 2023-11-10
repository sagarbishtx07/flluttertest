import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
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
              return Column(children: [
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                  const InputDecoration(hintText: 'Enter your email'),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: 'Enter pasword'),
                ),
                TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      final userCredentials = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email, password: password);
                      print(userCredentials);
                    } on FirebaseAuthException catch (e) {

                      if(e.code=='weak-password')
                        print("Weak Password Exception ${e.toString()}");
                      else if(e.code == "email-already-in-use")
                        print("Email Exception ${e.toString()}");
                      else if(e.code == "invalid-email")
                        print("Invalid Email Exception ${e.toString()}");
                    }
                  },
                  child: const Text("Register"),
                ),
              ]);
            default:
              return const Text("Loading...");
          // TODO: Handle this case.
          }
        },
      ),
    );
  }
}
