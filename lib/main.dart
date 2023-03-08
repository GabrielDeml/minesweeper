import 'package:flutter/material.dart';
import 'package:minesweeper/Screens/GameScreen.dart';
import 'package:provider/provider.dart';

import 'Providers/GridProvider.dart';
import 'Screens/StartScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GridProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Listen to the provider to rebuild the widget when the grid changes
      body: Consumer<GridProvider>(
        builder: (context, gridProvider, child) {
          // Show the start screen if the grid is empty
          return (gridProvider.boardState.isEmpty)
              ? const StartScreen()
              : const GameScreen();
        },
      ),
    );
  }
}
