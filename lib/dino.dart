import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_learning/constansts.dart';

enum DinoState { idle, running, hit }

class Dino extends SpriteAnimationGroupComponent {
  late Vector2 _gameSize;
  Dino(Vector2 gameSize) {
    _gameSize = gameSize;
  }

  double speedY = 0.0;
  double yMax = 250;
  double gravity = 1000;

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    Images images = Images();
    final spriteSheet = SpriteSheet(
      image: await images.load("DinoSprites - tard.png"),
      srcSize: Vector2(24, 24),
    );

    var idle =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 3);

    var running =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);

    var hit =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 14, to: 16);

    animations = {
      DinoState.running: running,
      DinoState.idle: idle,
      DinoState.hit: hit,
    };

    current = DinoState.running;

    caculateSize();
  }

  @override
  void update(double dt) {
    super.update(dt);

    //v=u + at
    speedY += gravity * dt;

    //d = s*t
    y += speedY * dt;

    if (_isOnGround()) {
      y = yMax;
      speedY = 0.0;
      current = DinoState.running;
    }
  }

  void jump() {
    if (_isOnGround()) {
      speedY -= 350;
      current = DinoState.idle;
    }
  }

  bool _isOnGround() {
    return y >= yMax;
  }

  void caculateSize() {
    size = Vector2(24, 24);
    yMax = _gameSize.y - groundHeight - height;
    const _x = 50.0;
    position = Vector2(_x, yMax);
  }
}
