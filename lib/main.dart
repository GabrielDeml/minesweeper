// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
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
          return (gridProvider.boardState.isEmpty)
              ? const StartScreen()
              : const GameScreen();
        },
      ),
    );
  }
}
