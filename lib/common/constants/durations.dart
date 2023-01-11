abstract class AnimationDuration {
  static const Duration extraShort = Duration(milliseconds: 100);
  static const Duration short = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration long = Duration(milliseconds: 750);
  static const Duration extraLong = Duration(milliseconds: 1250);
}

abstract class MockDuration {
  static const Duration oneSecond = Duration(seconds: 1);
}