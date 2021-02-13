// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';

void main() => runApp(
  GameWidget(
    game: GameClass()
  )
);

class MyApp extends StatelessWidget {

  final game = MyGame();

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
    );
  }
}

class GameClass extends Game {

  @override
  void render(Canvas canvas) {}

  @override
  void update(double t) {}
}

class MyCrate extends SpriteComponent {

  MyCrate(): super.fromSprite(
    Vector2(16.0, 16.0),
    new Sprite(Flame.images.fromCache('crate.png'))
  );

  @override
  void onGameResize(Vector2 gameSize) {
    this.x = (gameSize.x - this.width) / 2;
    this.y = (gameSize.y - this.height) / 2;
  }
}

class MyGame extends BaseGame {
  MyGame() {
    add(new MyCrate());
  }
}
