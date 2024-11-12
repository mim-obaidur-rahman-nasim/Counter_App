import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  void _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  void _increamentCounter() {
    setState(() {
      if (_counter < 50) {
        _counter++;
        _saveCounter();
      }
    });
  }

  void _decreamentCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _saveCounter();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _saveCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Counter App",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              _counter.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 200),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _resetCounter();
                    },
                    child: const Icon(Icons.restore)),
                ElevatedButton(
                    onPressed: () {
                      _increamentCounter();
                    },
                    child: const Icon(Icons.add)),
                ElevatedButton(
                    onPressed: () {
                      _decreamentCounter();
                    },
                    child: const Icon(Icons.remove)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
