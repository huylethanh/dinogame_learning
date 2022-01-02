import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame_learning/dino.dart';
import 'package:flame_learning/enemy_manager.dart';
import 'package:flutter/painting.dart';

class DinoGame extends FlameGame with TapDetector, HasCollidables {
  late Dino _dino;
  late ParallaxComponent _parallaxComponent;
  late TextComponent _textComponent;
  var score = 0;

  final _imageNames = {
    'parallax/plx-1.png': 1.0,
    'parallax/plx-2.png': 1.5,
    'parallax/plx-3.png': 2.3,
    'parallax/plx-4.png': 3.8,
    'parallax/plx-5.png': 6.6,
  };

  final _regular = TextPaint(
      style: TextStyle(fontSize: 18, color: BasicPalette.white.color));

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    camera.viewport = FixedResolutionViewport(Vector2(360, 180));

    _loadParallax();

    _textComponent =
        TextComponent(text: '0', textRenderer: _regular, priority: 1)
          ..anchor = Anchor.topCenter
          ..x = size.x / 2
          ..y = 5;

    _dino = Dino(size);

    add(_dino);

    // var enemy = Enemy(size, EnemyType.rino);
    //add(enemy);

    EnemyManager enemyManager = EnemyManager();
    add(enemyManager);

    add(_textComponent);
  }

  @override
  void onTap() {
    super.onTap();

    _dino.jump();
  }

  @override
  void update(double dt) {
    super.update(dt);
    score += 1;
    _textComponent.text = score.toString();
  }

  void _loadParallax() async {
    final layers = _imageNames.entries
        .map(
          (e) => ParallaxLayer.load(
            ParallaxImageData(e.key),
            velocityMultiplier: Vector2(e.value, 1.0),
          ),
        )
        .toList();

    final ground = ParallaxLayer.load(ParallaxImageData('parallax/plx-6.png'),
        fill: LayerFill.none, velocityMultiplier: Vector2(6.6, 1));

    layers.add(ground);

    _parallaxComponent = ParallaxComponent(
      parallax: Parallax(
        await Future.wait(layers),
        baseVelocity: Vector2(20, 0),
      ),
    );

    add(_parallaxComponent);
  }
}
