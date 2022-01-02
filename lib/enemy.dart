import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flame_learning/constansts.dart';
import 'package:flame_learning/enemy_data.dart';

class Enemy extends SpriteAnimationComponent with HasHitboxes, Collidable {
  late Vector2 _gameSize;
  final speed = 100.0;

  final Map<EnemyType, EnemyData> enemies = {
    EnemyType.pig: EnemyData("AngryPig/Walk (36x30).png", Vector2(36, 30), 15),
    EnemyType.bat: EnemyData("Bat/Flying (46x30).png", Vector2(46, 30), 7),
    EnemyType.rino: EnemyData("Rino/Run (52x34).png", Vector2(52, 34), 6),
  };

  late EnemyData _enemyData;

  Enemy(Vector2 gameSize, EnemyType enemyType) {
    _gameSize = gameSize;
    _enemyData = enemies[enemyType]!;
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    Images images = Images();
    final spriteSheet = SpriteSheet(
      image: await images.load(_enemyData.fileName),
      srcSize: _enemyData.textureSize,
    );

    animation = spriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 0, to: _enemyData.columns);
    size = Vector2(30, 30);

    caculateSize();
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
    x -= speed * dt;

    if (x < _enemyData.textureSize.x * -1) {
      shouldRemove = true;
    }
  }

  void caculateSize() {
    size = _enemyData.textureSize;
    final _x = _gameSize.x + width;
    final _y = _gameSize.y - groundHeight - height;

    position = Vector2(_x, _y);
  }
}
