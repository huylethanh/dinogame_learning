import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_learning/dino.dart';
import 'package:flame_learning/enemy.dart';
import 'package:flame_learning/enemy_data.dart';

class DinoGame extends FlameGame with TapDetector {
  late Dino _dino;
  late ParallaxComponent _parallaxComponent;
  late TextComponent textComponent;
  var score = 0;

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
    camera.viewport = FixedResolutionViewport(Vector2(360, 180));

    _loadParallax();

    _dino = Dino(size);

    add(_dino);

    textComponent = TextComponent(text: score.toString());
    textComponent.position = Vector2(5, 5);
    textComponent.size = Vector2(50, 50);
    add(textComponent);

    var enemy = Enemy(size, EnemyType.rino);
    add(enemy);
  }

  @override
  void onTap() {
    super.onTap();

    _dino.jump();
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
