
import 'dart:io';

import 'package:f1/videolistscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class VideoIntegration extends StatelessWidget {
  const VideoIntegration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Integration')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);

              if(result!=null){
                File file = File(result.files.single.path!);
                await uploadVideo(file);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Video uploaded successfully!'),
                  ),
                );
              }

            }, child: const Text('Upload Video')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){

Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoListScreen()));
            }, child: const Text('Video Link Url'))
          ],
        ),
      ),
    );
  }

  Future<void> uploadVideo(File file)async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    // Upload the video to Firebase Storage
    Reference storageReference =
    FirebaseStorage.instance.ref().child('videos/${DateTime.now()}.mp4');
    await storageReference.putFile(file);
  }
}
