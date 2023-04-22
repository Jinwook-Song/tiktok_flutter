import 'package:shared_preferences/shared_preferences.dart';

class VideoPlaybackConfigRepository {
  static const String _autoPlay = "autoPlay";
  static const String _muted = "muted";

  final SharedPreferences _preferences;

  VideoPlaybackConfigRepository(this._preferences);

  Future<void> setAutoPlay(bool value) async {
    _preferences.setBool(_autoPlay, value);
  }

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  bool isAutoPlay() {
    return _preferences.getBool(_autoPlay) ?? false;
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }
}
