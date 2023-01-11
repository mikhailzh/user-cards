import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';
import 'package:user_cards/common/constants/environment.dart';
import 'package:user_cards/domain/services/audio_service.dart';

@LazySingleton(as: AudioService, env: AppEnvironment.mocks)
class MockAudioService extends AudioService {
  final player = AudioPlayer();

  @override
  Future<void> pauseAudio() async {
    await player.pause();
  }

  @override
  Stream<bool> isRunning() {
    return player.onPlayerStateChanged.asBroadcastStream().map((event) => event == PlayerState.playing);
  }

  @override
  Future<Stream<double>> startAudio(String src) async {
    await player.play(AssetSource(src));
    final duration = await player.getDuration();
    return player.onPositionChanged
        .asBroadcastStream()
        .map((event) => duration != null ? event.inMicroseconds.toDouble() / duration.inMicroseconds : 0.5);
  }
}
