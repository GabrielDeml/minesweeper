// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BoardState.dart';
import 'CubeGrid.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
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
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
            CubeGrid(cells: gridProvider.boardState),
            const SizedBox(height: 20),
            (gridProvider.gameOver) ? ElevatedButton(
              onPressed: () {
                gridProvider.reset();
              },
              child: const Text('Reset'),
            ) : const SizedBox(height: 0),
            const SizedBox(height: 20),
            Text('Score: ${gridProvider.getScore()}'),
          ]);
        },
      ),
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  double _widthValue = 8;
  double _heightValue = 8;
  double _funValue = 0.7;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Width: ${_widthValue.round()}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Height: ${_heightValue.round()}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Fun: ${_funValue.toStringAsFixed(1)}',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slider(
            value: _widthValue,
            min: 0,
            max: 15,
            onChanged: (value) {
              setState(() {
                _widthValue = value;
              });
            },
            divisions: 15,
            label: 'Width: ${_widthValue.round()}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slider(
            value: _heightValue,
            min: 0,
            max: 15,
            onChanged: (value) {
              setState(() {
                _heightValue = value;
              });
            },
            divisions: 15,
            label: 'Height: ${_heightValue.round()}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slider(
            value: _funValue,
            min: 0,
            max: 1,
            onChanged: (value) {
              setState(() {
                _funValue = value;
              });
            },
            label: 'Fun: ${_funValue.toStringAsFixed(1)}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              context.read<GridProvider>().buildGrid(
                    _widthValue.round(),
                    _heightValue.round(),
                    _funValue,
                  );
            },
            child: const Text('Start'),
          ),
        ),
      ],
    );
  }
}

