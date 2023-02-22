/// domain - содержит абстракции всех бизнес-классов приложения и бизнес-модели
///
/// service - все что не попадает под описание interactor или repository
abstract class AudioService {
  Future<Stream<double>> startAudio(String src);
  Stream<bool> isRunning();
  Future<void> pauseAudio();
}