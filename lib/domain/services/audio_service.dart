abstract class AudioService {
  Future<Stream<double>> startAudio(String src);
  Stream<bool> isRunning();
  Future<void> pauseAudio();
}