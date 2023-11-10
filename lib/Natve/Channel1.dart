import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Channel1 extends StatefulWidget{
  @override
  _Channel1State createState()=>_Channel1State();
}

class _Channel1State extends State<Channel1>{
  static const platform = const MethodChannel('sample.flutter.dev/native');
  String _nativeMessage = "No message yet";

  Future<void> _getNativeMessage() async {
    String message;
    try {
      final result = await platform.invokeMethod('getNativeMessage');
      message = result;
    } on PlatformException catch (e) {
      message = "Failed to get native message: '${e.message}'.";
    }

    setState(() {
      _nativeMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Integration Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_nativeMessage),
            ElevatedButton(
              onPressed: _getNativeMessage,
              child: Text('Get Native Message'),
            ),
          ],
        ),
      ),
    );
  }
}