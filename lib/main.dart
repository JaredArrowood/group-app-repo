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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
      _appBarColor = colors[_counter % colors.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !_isPopped
                ? const Text(
                    'Inflate the ballon! (or deflate if you\'re evil)',
                  )
                : const Text(
                    'NOOO YOU POPPED THE BALLOON!',
                  ),
            !_isPopped
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
                  child: Text("Change the bar color."),
                )
              ],
            ),
          ],
        ),
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
            onPressed: () {
              setState(() {
                _isPopped = true;
              });
            },
            tooltip: 'Pop 🤯',
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
