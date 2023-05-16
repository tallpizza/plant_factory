import 'package:flutter/material.dart';
import 'package:plant_factory/circle.dart';

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
  var _count = 0;
  List<Widget> circleList = [];
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
          children: circleList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(
            () => circleList.add(const MyCircleWidget(topic: "mytopic/#"))),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
