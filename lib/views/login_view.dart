import 'package:f1/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                    try {
                      final email = _email.text;
                      final password = _password.text;
                      final userCredentials = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password);
                      print(userCredentials.toString());
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found')
                        print("USER NOT FOUND");
                      else {
                        print('Something else : ${e.code}');
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: const Text("Login"),
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
