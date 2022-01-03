import 'package:flame/widgets.dart';
import 'package:flame_learning/Models/player.dart';
import 'package:flame_learning/audio_manager.dart';
import 'package:flame_learning/game.dart';
import 'package:flame_learning/widgets/pause_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hub extends StatelessWidget {
  static const String HubId = "HubId";
  final DinoGame dinoGame;
  const Hub({required this.dinoGame, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: dinoGame.player,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpriteButton.asset(
                path: "pause-16.png",
                pressedPath: "pause-16.png",
                onPressed: () {
                  dinoGame.overlays.remove(Hub.HubId);
                  dinoGame.overlays.add(PauseMenu.PauseMenuId);
                  AudioManager.instance.pauseBgm();
                  dinoGame.pauseEngine();
                },
                width: 16,
                height: 16,
                label: const Text(""),
              ),
              Selector<Player, int>(
                  selector: (_, player) => player.score,
                  builder: (_, score, __) {
                    return Text(
                      score.toString(),
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontFamily: "Audiowide", color: Colors.white),
                    );
                  }),
              Selector<Player, int>(
                  selector: (_, player) => player.lives,
                  builder: (_, lives, __) {
                    return Row(
                        children: List.generate(Player.maxLives, (index) {
                      if (lives - 1 < index) {
                        return const Icon(
                          Icons.favorite_outline,
                          color: Colors.red,
                        );
                      }
                      return const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      );
                    }).toList());
                  })
            ],
          ),
        ));
  }
}
