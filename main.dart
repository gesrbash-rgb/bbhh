import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'services/stt_service.dart';
import 'services/translate_service.dart';
import 'services/summary_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = "";

  Future pickAndProcess() async {
    final file = await FilePicker.platform.pickFiles(type: FileType.video);
    if (file == null) return;

    final video = File(file.files.single.path!);

    final text = await STTService().process(video.path);
    final translated = await TranslateService().run(text);
    final summary = await SummaryService().run(text);

    setState(() {
      result = "$text\n\n$translated\n\n$summary";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Offline AI")),
      body: Column(
        children: [
          ElevatedButton(onPressed: pickAndProcess, child: Text("Start")),
          Expanded(child: SingleChildScrollView(child: Text(result)))
        ],
      ),
    );
  }
}
