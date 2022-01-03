import 'package:flutter/foundation.dart';

class Player extends ChangeNotifier {
  static const int maxLives = 5;
  int _lives = maxLives;
  int score = 0;

  int get lives => _lives;
  void lostLive() {
    _lives -= 1;
    notifyListeners();
  }

  void updateScore() {
    score += 1;
    notifyListeners();
  }
}
