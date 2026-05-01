import 'package:flutter/services.dart';

class STTService {
  static const channel = MethodChannel("whisper");

  Future<String> process(String path) async {
    final result = await channel.invokeMethod("transcribe", {"path": path});
    return result;
  }
}
