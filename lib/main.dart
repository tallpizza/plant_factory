import 'package:flutter/material.dart';
import 'mqttHandler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;
  MqttHandler mqttHandler = MqttHandler("mytopic/#");

  @override
  void initState() {
    super.initState();
    mqttHandler.connect();
  }

  var _top = 0.0;
  var _left = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Data received:',
                  style: TextStyle(color: Colors.black, fontSize: 25)),
              ValueListenableBuilder<String>(
                  builder: (BuildContext context, String value, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("$value °C",
                            style: const TextStyle(
                                color: Colors.deepPurpleAccent, fontSize: 35))
                      ],
                    );
                  },
                  valueListenable: mqttHandler.temp),
              ValueListenableBuilder<String>(
                  builder: (BuildContext context, String value, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("$value%",
                            style: const TextStyle(
                                color: Colors.deepPurpleAccent, fontSize: 35))
                      ],
                    );
                  },
                  valueListenable: mqttHandler.humi),
            ],
          ),
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _top += details.delta.dy;
                  _left += details.delta.dx;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
