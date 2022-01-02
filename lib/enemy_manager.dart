import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_learning/enemy.dart';
import 'package:flame_learning/enemy_data.dart';
import 'package:flame_learning/game.dart';

class EnemyManager extends Component with HasGameRef<DinoGame> {
  late Random _random;
  late int _max;
  late Timer _timer;

  EnemyManager() {
    _random = Random();
    _max = EnemyType.values.length;
    _timer =
        Timer(4, repeat: true, onTick: () => spawnEnemy(), autoStart: true);
  }

  void spawnEnemy() {
    final index = _random.nextInt(_max);
    final type = EnemyType.values[index];

    final newEnemy = Enemy(gameRef.size, type);
    gameRef.add(newEnemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _timer.update(dt);
  }
}
