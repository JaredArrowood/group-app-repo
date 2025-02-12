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

  String _balloonIcon = '🎈'; // Default balloon icon

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
        ConfettiController(duration: const Duration(milliseconds: 700));
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
    if (_counter < 1) return;

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

  /// Navigate to the Balloon Selection Page and update the balloon icon
  void _navigateToBalloonSelection() async {
    final selectedBalloon = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BalloonSelectionPage(currentBalloon: _balloonIcon),
      ),
    );

    if (selectedBalloon != null) {
      setState(() {
        _balloonIcon = selectedBalloon;
      });
    }
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
              Image.asset(
                'assets/doggie.png',
                width: 200,
                height: 150,
                fit: BoxFit.contain,
              ),
              _counter < 20 && !_isPopped
                  ? const Text(
                      'Inflate my balloon! (or deflate if you\'re evil)',
                    )
                  : const Text(
                      'NOOO YOU POPPED MY BALLOON!',
                    ),
              _counter < 20 && !_isPopped
                  ? Text(
                      _balloonIcon, 
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
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _navigateToBalloonSelection,
                    child: const Text("Choose Balloon 🎈"),
                  ),
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

// Balloon Picker Page
class BalloonSelectionPage extends StatelessWidget {
  final String currentBalloon;

  const BalloonSelectionPage({super.key, required this.currentBalloon});

  @override
  Widget build(BuildContext context) {
    List<String> balloons = ['🎈', '🎃', '🎁', '⚽', '💡', '🍎'];

    return Scaffold(
      appBar: AppBar(title: const Text("Select a Balloon")),
      body: ListView(
        children: balloons.map((balloon) {
          return ListTile(
            title: Text(
              balloon,
              style: const TextStyle(fontSize: 40),
            ),
            trailing: currentBalloon == balloon
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              Navigator.pop(context, balloon); 
            },
          );
        }).toList(),
      ),
    );
  }
}
