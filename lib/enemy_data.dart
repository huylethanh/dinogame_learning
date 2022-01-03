import 'package:flame/components.dart';

enum EnemyType { pig, bat, rino }

class EnemyData {
  final String fileName;
  final Vector2 textureSize;
  final int columns;
  final bool canFly;
  final double speed;

  EnemyData(this.fileName, this.textureSize, this.columns, this.speed,
      {this.canFly = false});
}
