import 'package:flutter/material.dart';
import 'package:minesweeper/Screens/GameScreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Listen to the provider to rebuild the widget when the grid changes
          Consumer<GridProvider>(
            builder: (context, gridProvider, child) {
              // Show the start screen if the grid is empty
              return (gridProvider.boardState.isEmpty)
                  ? const StartScreen()
                  : const GameScreen();
            },
          ),
          // Link to the source code
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                child: const Text('Source code'),
                onPressed: () => launchUrl(
                    Uri.parse('https://github.com/GabrielDeml/minesweeper')),
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
