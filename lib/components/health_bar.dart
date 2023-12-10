import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HealthBar extends PositionComponent {
  double maxHealth;
  double currentHealth;
  final double heightFire;
  final Color backgroundColor;
  final Color foregroundColor;

  HealthBar({
    required this.maxHealth,
    required this.currentHealth,
    required this.foregroundColor,
    required Vector2 position,
    required Vector2 size,
    this.heightFire = 20,
    this.backgroundColor = Colors.grey,
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Draw background
    final paintBackground = Paint()..color = backgroundColor;
    canvas.drawRect(size.toRect(), paintBackground);

    // Calculate health bar width
    final double ratio = currentHealth / maxHealth;
    final double healthBarWidth = size.x * ratio;

    // Draw health bar
    final paintHealth = Paint()..color = foregroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, healthBarWidth, height), paintHealth);
  }

  void updateHealth(double value) {
    currentHealth = value.clamp(0, maxHealth);
  }
}