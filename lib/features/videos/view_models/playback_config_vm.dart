import 'package:flutter/material.dart';
import 'package:tiktok_flutter/features/videos/models/playback_config_model.dart';
import 'package:tiktok_flutter/features/videos/repositories/playback_config_repository.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoPlay: _repository.isAutoPlay(),
  );

  // getter
  // repository가 api를 사용하고 있다면 매번 api 요청을 하게되므로 반드시 피해야한다
  // bool get muted => _repository.isMuted(); ❌
  bool get muted => _model.muted; // ✅ caching
  bool get autoPlay => _model.autoPlay;

  // setter
  void setMuted(bool value) {
    // set on disk
    _repository.setMuted(value);
    // modify data
    _model.muted = value;
    // expose to views
    notifyListeners();
  }

  void setAutoPlay(bool value) {
    _repository.setAutoPlay(value);
    _model.autoPlay = value;
    notifyListeners();
  }
}
