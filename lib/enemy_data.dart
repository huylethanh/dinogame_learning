import 'package:flame/components.dart';

enum EnemyType { pig, bat, rino }

class EnemyData {
  final String fileName;
  final Vector2 textureSize;
  final int columns;

  EnemyData(this.fileName, this.textureSize, this.columns);
}
