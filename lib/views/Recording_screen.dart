import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordingView extends StatefulWidget {
  const RecordingView({super.key});

  @override
  State<RecordingView> createState() => _RecordingViewState();
}

class _RecordingViewState extends State<RecordingView> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioRecorder audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? path;
  late String? _recording;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recording View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              startRecording();
            }, child: const Text("Start Recording"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              stopRecording();
            }, child: const Text("Stop Recording")),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              playAudio("path");
            }, child: const Text('Play Audio'))

          ],
        ),

      ),
    );
  }

  Future<void> startRecording() async {
    bool hasPermissions = await AudioRecorder().hasPermission();
    if (!hasPermissions) {
      return;
    } else {
      RecordConfig rc = const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
        numChannels: 2,
      );
      Directory appDir = await getApplicationDocumentsDirectory();
      String audioFilePath = '${appDir.path}/recorded_audio.aac';
      path = audioFilePath;
      await audioRecorder.start(rc, path: audioFilePath);

      setState(() {
        _isRecording = true;
      });
    }
  }

  void stopRecording() async {
    await audioRecorder.stop();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> playAudio(String s) async {
    try {
      if (path != null && !_isRecording) {
        await audioPlayer.play(
          path! as Source,
          volume: 1.0, // Adjust the volume if needed
          balance: 0.0, // Adjust the balance if needed
        );

        print("Playback started successfully");
      }
    } catch (e) {
      print("Error starting playback: $e");
    }

   /* audioPlayer.onPlayerCompletion.listen((event) {
      // Handle completion (e.g., update UI)
      print("Playback completed");
    });*/
  }
}
