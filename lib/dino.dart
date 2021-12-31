import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

enum DinoState {
  idle,
  running,
}

class Dino extends SpriteAnimationGroupComponent {
  late SpriteSheet _spriteSheet;
  Dino(SpriteSheet spriteSheet) {
    _spriteSheet = spriteSheet;
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    var idle =
        _spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 3);

    var running =
        _spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);

    final dinoSize = Vector2(64, 72);

    animations = {
      DinoState.running: running,
      DinoState.idle: idle,
    };
    current = DinoState.running;
    position = Vector2(100, 250);
    size = dinoSize;
  }
}
