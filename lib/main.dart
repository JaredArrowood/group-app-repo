import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '🤡'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isPopped = false;
  late ConfettiController _confettiController;

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
    Colors.lime,
    Colors.amber,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey
  ];

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(microseconds: 200));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    if (_counter < 20) {
      setState(() {
        _counter++;
      });
    }

    if (_counter >= 20 && !_isPopped) {
      _popBalloon();
    }
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  Color _appBarColor = Colors.deepPurple;

  void _setAppBarColor() {
    setState(() {
      _appBarColor = colors[Random().nextInt(colors.length)];
    });
  }

  void _popBalloon() {
    if (!_isPopped) {
      setState(() {
        _isPopped = true;
        _confettiController.play();
      });
    }
  }

  void resetState() {
    setState(() {
      _counter = 0;
      _isPopped = false;
    });
    _confettiController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColor,
        title: Text(widget.title),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _counter < 20 && !_isPopped
                  ? const Text(
                      'Inflate the balloon! (or deflate if you\'re evil)',
                    )
                  : const Text(
                      'NOOO YOU POPPED THE BALLOON!',
                    ),
              _counter < 20 && !_isPopped
                  ? Text(
                      '🎈',
                      style: TextStyle(fontSize: _counter * 10.0),
                    )
                  : const Text(
                      '💥',
                      style: TextStyle(fontSize: 100.0),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _setAppBarColor();
                    }),
                    child: const Text("Change the bar color."),
                  )
                ],
              ),
            ],
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 50,
            gravity: 0.15,
            emissionFrequency: 0.05,
            colors: [
              Colors.black,
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Inflate 🌬️',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Deflate 😔',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: _popBalloon,
            tooltip: 'Pop 🤯',
            child: const Icon(Icons.delete),
          ),
          FloatingActionButton(
            onPressed: resetState,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
