import 'package:flutter/services.dart';

class SummaryService {
  static const channel = MethodChannel("onnx");

  Future<String> run(String text) async {
    return await channel.invokeMethod("summarize", {"text": text});
  }
}
