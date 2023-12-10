import 'package:firepoteto/poteto_world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class PotetoGame extends FlameGame with HasCollisionDetection{

  PotetoGame(): super(
      camera: CameraComponent.withFixedResolution(
        width: 1280,
        height: 720,
      )..viewfinder.anchor = Anchor.topLeft,
      world: PotetoWorld()
  );

}