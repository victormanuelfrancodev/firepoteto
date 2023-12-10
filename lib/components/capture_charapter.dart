import 'package:firepoteto/components/flame_charapter.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import '../poteto_game.dart';
import '../poteto_world.dart';

enum Capture{
  flame, ice, enemy
}

class CaptureCharapter extends SpriteComponent with CollisionCallbacks, HasGameRef<PotetoGame>{

  CaptureCharapter(this.capture, Vector2 size, Vector2 position)
      : super(size: size, position: position);

  late Paint colorBackground;
  Capture capture;
  double speed = 2;

  @override
  onLoad() async{
    add(RectangleHitbox());
    if(capture == Capture.flame){
      sprite = await Sprite.load('fire.png');
      colorBackground = Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 5.0
        ..color = Colors.deepOrange.withOpacity(0.8);
    }else if(capture == Capture.ice){
      sprite = await Sprite.load('ice.png');
      colorBackground = Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 5.0
        ..color = Colors.blueAccent.withOpacity(0.8);
    }else{
      sprite = await Sprite.load('skull.png');
      colorBackground = Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 5.0
        ..color = Colors.grey.withOpacity(0.8);
    }

    paint = colorBackground;
    add(ColorEffect(colorBackground.color, EffectController( duration: 1.5,
      reverseDuration: 1.5,
      infinite: true,)));
  }

  @override
  void update(double dt) {
    position.y += speed;
    if(position.y >  gameRef.size.y){
      removeFromParent();
    }
    if( (gameRef.world as PotetoWorld).iceBar.currentHealth >= 100
        && (gameRef.world as PotetoWorld).fireBar.currentHealth >= 100 ){
      gameRef.overlays.add('win');
      gameRef.paused = true;
    }else if ((gameRef.world as PotetoWorld).lifeBar.currentHealth <= 0){
      gameRef.overlays.add('gameover');
      gameRef.paused = true;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is FlameCharapter){
      if(capture == Capture.flame){
        other.addFire();
        (gameRef.world as PotetoWorld).fireBar.updateHealth((gameRef.world as PotetoWorld).fireBar.currentHealth + 5);
      }else if(capture == Capture.ice){
        other.addVelocity();
        (gameRef.world as PotetoWorld).iceBar.updateHealth((gameRef.world as PotetoWorld).iceBar.currentHealth + 5);
      }else if(capture == Capture.enemy){
        speed += 0.5;
        (gameRef.world as PotetoWorld).lifeBar.updateHealth((gameRef.world as PotetoWorld).lifeBar.currentHealth - 10);
      }
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}