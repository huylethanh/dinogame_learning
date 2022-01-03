import 'dart:ui';

import 'package:flame_learning/audio_manager.dart';
import 'package:flame_learning/game.dart';
import 'package:flame_learning/widgets/hub.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  static const String PauseMenuId = "PauseMenuId";
  final DinoGame dinoGame;

  const PauseMenu({required this.dinoGame, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      dinoGame.overlays.remove(PauseMenu.PauseMenuId);
                      dinoGame.overlays.add(Hub.HubId);
                      AudioManager.instance.resumeBgm();
                      dinoGame.resumeEngine();
                    },
                    child: const Text(
                      'Resume',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
