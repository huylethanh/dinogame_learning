import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flame_learning/Models/player.dart';
import 'package:flame_learning/coin.dart';
import 'package:flame_learning/constansts.dart';
import 'package:flame_learning/enemy.dart';
import 'audio_manager.dart';

enum DinoState {
  idle,
  running,
  hit,
  fall,
}

class Dino extends SpriteAnimationGroupComponent
    with HasHitboxes, Collidable, HasGameRef {
  late Vector2 _gameSize;
  late Timer _hitTimer;
  //late int health = 3;
  final Player player;

  Dino(this.player);

  double speedY = 0.0;
  double yMax = 300;
  double gravity = 1000;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    _gameSize = gameRef.size;
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

    var fall = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      from: 16,
    );

    animations = {
      DinoState.running: running,
      DinoState.idle: idle,
      DinoState.hit: hit,
      DinoState.fall: fall,
    };

    current = DinoState.running;

    _hitTimer = Timer(1, onTick: () {
      current = DinoState.running;
    });

    caculateSize();
  }

  @override
  void onMount() {
    super.onMount();

    final shape = HitboxRectangle(relation: Vector2(0.5, 0.7));
    addHitbox(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy && current != DinoState.hit) {
      hit(other);
    }

    if (other is Coin) {
      player.pickCoin();
      other.reset();
    }
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

      if (current != DinoState.hit) {
        current = DinoState.running;
      }
    }

    _hitTimer.update(dt);
  }

  void jump() {
    if (_isOnGround()) {
      speedY -= 400;
      current = DinoState.idle;
      AudioManager.instance.playSfx('jump14.wav');
    }
  }

  void hit(Enemy enemy) {
    //enemy.removeFromParent();
    player.lostLive();
    AudioManager.instance.playSfx('hurt7.wav');
    if (player.lives <= 0) {
      current = DinoState.fall;
      return;
    }

    current = DinoState.hit;
    _hitTimer.start();
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
