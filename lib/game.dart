import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';

enum DinoState {
  idle,
  running,
}

class DinoGame extends FlameGame {
  late SpriteAnimationGroupComponent _dino;
  late ParallaxComponent _parallaxComponent;

  final _imageNames = [
    ParallaxImageData('parallax/plx-1.png1'),
    ParallaxImageData('parallax/plx-2.png'),
    ParallaxImageData('parallax/plx-3.png'),
    ParallaxImageData('parallax/plx-4.png'),
    ParallaxImageData('parallax/plx-5.png'),
  ];

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    final spriteSheet = SpriteSheet(
      image: await images.load("DinoSprites - tard.png"),
      srcSize: Vector2(24, 24),
    );

    var idle =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 3);

    var running =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);

    final dinoSize = Vector2(64, 72);

    _dino = SpriteAnimationGroupComponent<DinoState>(
      animations: {
        DinoState.running: running,
        DinoState.idle: idle,
      },
      current: DinoState.running,
      position: size / 2,
      size: dinoSize,
    );

    add(_dino);

    _parallaxComponent = await ParallaxComponent.load(
      _imageNames,
      baseVelocity: Vector2(20, 0),
    );

    add(_parallaxComponent);
  }
}
