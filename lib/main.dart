import 'package:f1/Natve/Channel1.dart';
import 'package:f1/videointegration.dart';
import 'package:f1/views/Recording_screen.dart';
import 'package:f1/views/firebasehome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'YOUR_RECAPTCHA_SITE_KEY');

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MainIndex(),
  ));
}

class MainIndex extends StatelessWidget {
  const MainIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "MainIndex",
            style: TextStyle(color: Colors.amber),
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xD20B0B13), // Dark, very translucent blue background
          ),
          child: ListView(
            children: [
              Card(
                margin: const EdgeInsets.all(8.0),
                color: Colors.black54,
                child: ListTile(
                  title: const Text(
                    "Firebase Home",
                    style: TextStyle(color: Colors.amber),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FirebaseHome()),
                    );
                  },
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.9),
                color: Colors.black54,
                child: ListTile(
                    title: const Text(
                      "Channel 1",
                      style: TextStyle(color: Colors.amber),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Channel1()),
                      );
                    }),
              ),
              Card(
                margin: const EdgeInsets.all(8.9),
                color: Colors.black54,
                child: ListTile(
                    title: const Text(
                      "VideoIntegration",
                      style: TextStyle(color: Colors.amber),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VideoIntegration()),
                      );
                    }),
              ),
              Card(
                margin:const EdgeInsets.all(8.9),
                color:Colors.black54,
                child:ListTile(
                  title:const Text(
                    'Recording Integration',
                    style:TextStyle(color:Colors.amber),
                  ),
                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(context)=>const RecordingView()
                      )
                    );
                  }
                )
              )
            ],
          ),
        ));
  }
}
