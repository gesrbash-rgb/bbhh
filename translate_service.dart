import 'package:flutter/services.dart';

class TranslateService {
  static const channel = MethodChannel("onnx");

  Future<String> run(String text) async {
    return await channel.invokeMethod("translate", {"text": text});
  }
}
