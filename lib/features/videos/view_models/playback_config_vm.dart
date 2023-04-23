import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/videos/models/playback_config_model.dart';
import 'package:tiktok_flutter/features/videos/repositories/playback_config_repository.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    // set on disk
    _repository.setMuted(value);
    // modify data (immutable)
    state = PlaybackConfigModel(
      muted: value,
      autoPlay: state.autoPlay,
    );
  }

  void setAutoPlay(bool value) {
    _repository.setAutoPlay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoPlay: value,
    );
  }

  // initial data state user will get
  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoPlay: _repository.isAutoPlay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(), // repository를 await 해야하기 때문에
);
