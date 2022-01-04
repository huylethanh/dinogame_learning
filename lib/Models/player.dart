import 'package:flame/timer.dart';
import 'package:flutter/foundation.dart';

class Player extends ChangeNotifier {
  static const int maxLives = 5;
  int _lives = maxLives;
  int score = 0;
  int coin = 0;
  bool invisible = false;
  late Timer _timer;

  Player() {
    _timer = Timer(
      2,
      onTick: () => setUninvisible(),
    );
  }

  int get lives => _lives;
  void lostLive() {
    _lives -= 1;
    notifyListeners();
  }

  void updateScore() {
    score += 1;
    notifyListeners();
  }

  void reset() {
    score = 0;
    _lives = maxLives;
  }

  void pickCoin() {
    coin += 1;
    notifyListeners();
  }

  void updateTimer(double dt) {
    _timer.update(dt);
  }

  void setInvisible() {
    invisible = true;
    _timer.start();
    notifyListeners();
  }

  void setUninvisible() {
    invisible = false;
    notifyListeners();
  }
}
