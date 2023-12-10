import 'dart:math';
import 'package:firepoteto/components/flame_charapter.dart';
import 'package:firepoteto/poteto_game.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'components/capture_charapter.dart';
import 'components/health_bar.dart';

class PotetoWorld extends World with HasGameRef<PotetoGame> {
  final paintCharapter = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 5.0
    ..color = Colors.deepOrange.withOpacity(0.5);

  final paintCharapter2 = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 5.0
    ..color = Colors.blueAccent.withOpacity(0.5);


  late Timer _timer;
  final double timeInAppearEachObstacle = 2;
  late final JoystickComponent joystick;
  late final FlameCharapter flameCharapter;
  late Vector2 cameraSize;
  late HealthBar fireBar;
  late HealthBar iceBar;
  late HealthBar lifeBar;



  void appearOperation() async {
    add(createRandomCaptureCharapter(cameraSize));
  }

  @override
  void onLoad() async {
    cameraSize = gameRef.size;

    final sprite = await Sprite.load('background.png');
    final component = SpriteComponent(sprite: sprite, size: cameraSize);
    add(component);

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    _timer = Timer(timeInAppearEachObstacle,
        onTick: () => appearOperation(), repeat: true);
    _timer.start();

    flameCharapter = FlameCharapter(
        Vector2(25, 25), Vector2(25, gameRef.size.y - 25), joystick);

    add(flameCharapter);
    add(joystick);

    fireBar = HealthBar(
      maxHealth: 100,
      currentHealth: 00,
      position: Vector2(50, 50),
      size: Vector2(200, 20),
      foregroundColor: Colors.orange,
    );

    add(fireBar);

    final spriteFire = await Sprite.load('fire.png');
    final componentFire = SpriteComponent(
        sprite: spriteFire, size: Vector2(25, 25), position: Vector2(25, 45));
    add(componentFire);

    iceBar = HealthBar(
      maxHealth: 100,
      currentHealth: 00,
      position: Vector2(50, 80),
      size: Vector2(200, 20),
      foregroundColor: Colors.blue,
    );

    final spriteIce = await Sprite.load('ice.png');
    final componentIce = SpriteComponent(
        sprite: spriteIce, size: Vector2(25, 25), position: Vector2(25, 80));
    add(componentIce);

    add(iceBar);

    final spriteHeart = await Sprite.load('heart.png');
    final componentHeart = SpriteComponent(
        sprite: spriteHeart, size: Vector2(25, 25), position: Vector2(25, 110));
    add(componentHeart);

    lifeBar = HealthBar(
      maxHealth: 100,
      currentHealth: 100,
      position: Vector2(50, 110),
      size: Vector2(200, 20),
      foregroundColor: Colors.red,
    );

    add(lifeBar);
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  CaptureCharapter createRandomCaptureCharapter(Vector2 cameraSize) {
    Random random = Random();
    Capture captureType = Capture.values[random.nextInt(Capture.values.length)];

    Vector2 size = Vector2(50, 50);
    Vector2 position = Vector2(random.nextDouble() * cameraSize.x, 35);

    return CaptureCharapter(captureType, size, position);
  }
}
