import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flame_learning/constansts.dart';

class Banana extends SpriteAnimationComponent
    with HasGameRef, HasHitboxes, Collidable {
  late Random _random;

  Banana() {
    _random = Random();
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    Images images = Images();
    final spriteSheet = SpriteSheet(
      image: await images.load("banana.png"),
      srcSize: Vector2(47, 55),
    );

    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0);
    size = Vector2(20, 20);
    _position();
  }

  @override
  void onMount() {
    super.onMount();
    final shape = HitboxRectangle(relation: Vector2.all(0.8));
    addHitbox(shape);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (x <= 0) {
      _position();
    } else {
      x -= 130 * dt;
    }
  }

  void reset() {
    _position();
  }

  void _position() {
    final _y = gameRef.size.y - groundHeight - (height) - _random.nextInt(50);
    position = Vector2(gameRef.size.x - width, _y);
  }
}
