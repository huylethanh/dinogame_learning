import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flame_learning/dino.dart';

// enum DinoState {
//   idle,
//   running,
// }

class DinoGame extends FlameGame {
  late SpriteAnimationGroupComponent _dino;
  late ParallaxComponent _parallaxComponent;

  final _imageNames = {
    'parallax/plx-1.png': 1.0,
    'parallax/plx-2.png': 1.5,
    'parallax/plx-3.png': 2.3,
    'parallax/plx-4.png': 3.8,
    'parallax/plx-5.png': 6.6,
  };

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    final spriteSheet = SpriteSheet(
      image: await images.load("DinoSprites - tard.png"),
      srcSize: Vector2(24, 24),
    );

    // var idle =
    //     spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 3);

    // var running =
    //     spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);

    // final dinoSize = Vector2(64, 72);

    // _dino = SpriteAnimationGroupComponent<DinoState>(
    //   animations: {
    //     DinoState.running: running,
    //     DinoState.idle: idle,
    //   },
    //   current: DinoState.running,
    //   position: Vector2(100, size.y - 90),
    //   size: dinoSize,
    // );

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
        baseVelocity: Vector2(30, 0),
      ),
    );

    add(_parallaxComponent);
    add(Dino(spriteSheet));
  }
}
