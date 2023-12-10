import 'package:firepoteto/poteto_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(game: PotetoGame(), overlayBuilderMap: {
        'gameover': (context, game) => Container(
          decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                image: DecorationImage(
                  image: AssetImage("assets/images/loose.png"),
                  fit: BoxFit.cover,
                ),
              ),

              child: Center(
                child: TextButton(
                  onPressed: () {
                  },
                  child: const Text('Game Over You didnt manage to unify the worlds of fire and ice, try again',
                  style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                ),
              ),
            ),
        'win': (context, game) => Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage("assets/images/win.png"),
              fit: BoxFit.cover,
            ),
          ),

          child: Center(
            child: TextButton(
              onPressed: () {
              },
              child: const Text('You successfully unified the worlds of fire and ice! Win!',style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            ),
          ),
        ),
      }
    ));
  }
}
