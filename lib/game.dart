import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_learning/Models/player.dart';
import 'package:flame_learning/audio_manager.dart';
import 'package:flame_learning/banana.dart';
import 'package:flame_learning/coin.dart';
import 'package:flame_learning/dino.dart';
import 'package:flame_learning/enemy_manager.dart';
import 'package:flame_learning/widgets/game_over.dart';
import 'package:flame_learning/widgets/hub.dart';

class DinoGame extends FlameGame with TapDetector, HasCollidables {
  late Dino _dino;
  late ParallaxComponent _parallaxComponent;
  late TextComponent _textComponent;
  var score = 0;
  late Player player = Player();

  final _imageNames = {
    'parallax/plx-1.png': 1.0,
    'parallax/plx-2.png': 1.5,
    'parallax/plx-3.png': 2.3,
    'parallax/plx-4.png': 3.8,
    'parallax/plx-5.png': 6.6,
  };

  static const _audioAssets = [
    'Chiptune Dream Loop.wav',
    '8Bit Platformer Loop.wav',
    'hurt7.wav',
    'jump14.wav',
  ];

  late EnemyManager _enemyManager;

  DinoGame() {
    player.addListener(() {
      if (player.invisible) {
        _parallaxComponent.parallax?.baseVelocity = Vector2(100, 0);
      } else {
        _parallaxComponent.parallax?.baseVelocity = Vector2(20, 0);
      }
    });
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    camera.viewport = FixedResolutionViewport(Vector2(360, 180));
    AudioManager.instance.init(_audioAssets);
    _loadParallax();

    final coin = Coin();
    add(coin);

    final banana = Banana();
    add(banana);

    startGamePlay();
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();

    AudioManager.instance.startBgm("8Bit Platformer Loop.wav");
  }

  @override
  void onTap() {
    super.onTap();
    _dino.jump();
  }

  @override
  void update(double dt) {
    super.update(dt);
    player.updateScore();

    if (player.lives <= 0) {
      overlays.add(GameOver.id);
      overlays.remove(Hub.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
      return;
    }
  }

  void startGamePlay() {
    _dino = Dino(player);
    _enemyManager = EnemyManager();
    add(_dino);
    add(_enemyManager);
  }

  // This method remove all the actors from the game.
  void _disconnectActors() {
    _dino.removeFromParent();
    _enemyManager.removeAllEnemies();
    _enemyManager.removeFromParent();
  }

  // This method reset the whole game world to initial state.
  void reset() {
    _enemyManager.clear();

    // First disconnect all actions from game world.
    _disconnectActors();

    // Reset player data to inital values.
    player.reset();
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
