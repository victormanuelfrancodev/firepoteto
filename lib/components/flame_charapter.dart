import 'package:firepoteto/poteto_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum FlameDirection {
  left,
  right,
}

class FlameCharapter extends SpriteComponent with CollisionCallbacks,HasGameRef<PotetoGame>{

  FlameCharapter(Vector2 size, Vector2 position,this.joystick)
      : super(size: size, position: position);

  final JoystickComponent joystick;
  late  FlameDirection flameDirection = FlameDirection.right;
  late double grow = 10;
  late double velocity = 5;

  @override
  onLoad() async{
    sprite = await Sprite.load('flame.png');
    add(RectangleHitbox());
  }

  addFire(){
    size.y += grow;
    size.x += grow;
    size = Vector2(size.x, size.y);
    position = Vector2(position.x, gameRef.size.y - size.y);
  }

  addVelocity(){
    velocity += 2;
  }

  @override
  void update(double dt){
    if(joystick.direction == JoystickDirection.left){
      flameDirection = FlameDirection.left;
    }
    if(joystick.direction == JoystickDirection.right){
      flameDirection = FlameDirection.right;
    }

    if(flameDirection == FlameDirection.left){
      if(position.x > 0){
        position.x -= velocity;
      }else{
        flameDirection = FlameDirection.right;
      }
    }else{
      if(position.x + size.x < game.size.x){
        position.x += velocity;
      }else{
        flameDirection = FlameDirection.left;
      }
    }
  }

}