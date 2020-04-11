import 'package:detector_copos_latinhas/components/Camera.dart';
import 'package:detector_copos_latinhas/components/Render.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  setRecognitions(recognitions, imageHeight, imageWidth) {
    print('rec: ${recognitions[0]}');
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Camera(setRecognitions),
          Render(
            _recognitions == null ? [] : _recognitions,
          ),
        ],
      ),
    );
  }
}
