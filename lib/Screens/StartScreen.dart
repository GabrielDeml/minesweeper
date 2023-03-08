import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/GridProvider.dart';

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
