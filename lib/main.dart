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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: _top,
              left: _left,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    if (_top + details.delta.dy < 100 &&
                        _top + details.delta.dy > 0) {
                      _top += details.delta.dy;
                    }
                    if (_left + details.delta.dx <
                            MediaQuery.of(context).size.width - 220 &&
                        _left + details.delta.dx > 0) {
                      _left += details.delta.dx;
                    }
                  });
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<String>(
                          builder: (BuildContext context, String value,
                              Widget? child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("$value%",
                                    style: const TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 35))
                              ],
                            );
                          },
                          valueListenable: mqttHandler.humi),
                      ValueListenableBuilder<String>(
                          builder: (BuildContext context, String value,
                              Widget? child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("$value °C",
                                    style: const TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 35))
                              ],
                            );
                          },
                          valueListenable: mqttHandler.temp),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
