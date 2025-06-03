import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playKeySound() async {
    await _player.play(AssetSource('sounds/key_press.wav'));
  }

  Future<void> playErrorSound() async {
    await _player.play(AssetSource('sounds/error.wav'));
  }

  Future<void> playCompleteSound() async {
    await _player.play(AssetSource('sounds/complete.wav'));
  }

  void dispose() {
    _player.dispose();
  }
}
