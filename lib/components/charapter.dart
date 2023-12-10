
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flutter/material.dart';

class Charapter extends RectangleComponent{

  Charapter(Vector2 size, Vector2 position, Paint paint)
      : super(size: size, position: position, paint: paint);

  @override
   onLoad() {
    debugMode = true;
   add(
      SequenceEffect(
        [
          MoveEffect.by(
            Vector2(5, 0),
            PerlinNoiseEffectController(duration: 1, frequency: 20),
          ),
          MoveEffect.by(Vector2.zero(), LinearEffectController(2)),
          MoveEffect.by(
            Vector2(0, 10),
            PerlinNoiseEffectController(duration: 1, frequency: 10),
          ),
        ],
        infinite: true,
      ),
    );

  }
}