import 'package:flutter/material.dart';

import 'mqttHandler.dart';

class MyCircleWidget extends StatefulWidget {
  final String topic;
  const MyCircleWidget({Key? key, required this.topic}) : super(key: key);

  @override
  State<MyCircleWidget> createState() => _MyCircleWidgetState();
}

class _MyCircleWidgetState extends State<MyCircleWidget> {
  late MqttHandler mqttHandler = MqttHandler(widget.topic);
  @override
  void initState() {
    super.initState();
    mqttHandler.connect();
  }

  var _top = 0.0;
  var _left = 0.0;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            if (_top + details.delta.dy < 100 && _top + details.delta.dy > 0) {
              _top += details.delta.dy;
            }
            if (_left + details.delta.dx < 220 &&
                _left + details.delta.dx > 0) {
              _left += details.delta.dx;
            }
          });
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 156, 56, 173),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
