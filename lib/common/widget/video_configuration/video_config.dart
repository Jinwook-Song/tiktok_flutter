import 'package:flutter/material.dart';

// API를 사용하거나 데이터가 많을 때 유용하다
class VideoConfig extends ChangeNotifier {
  bool autoMute = false;

  void toggleAutoMute() {
    autoMute = !autoMute;
    // autoMute값을 듣고있는 곧에서 변경사항을 알 수 있도록
    notifyListeners();
  }
}

final vidoeConfig = VideoConfig();
