// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final image = Flame.images.load('map.png');
  final game = MyGame();

  Widget pauseMenuBuilder(BuildContext context, MyGame game) {
    return Text("A pause menu");
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
      overlayBuilderMap: {
        'PauseMenu': pauseMenuBuilder,
      },
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

  final image = Image(image: AssetImage('assets/map.png'));

  MyCrate(): super.fromSprite(
    Vector2(16.0, 16.0),
    new Sprite()
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
