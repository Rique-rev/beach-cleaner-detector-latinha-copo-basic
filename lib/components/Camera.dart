import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {

  final Callback setRecognitions;

  Camera(this.setRecognitions);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController _cameraController;
  var _recognitions;

  @override
  void initState() {
    super.initState();

    loadModel().then((_) {});

    loadCamera().then((cameras) {
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
        showCamera();
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;

    var screenW = math.min(tmp.height, tmp.width);
    tmp = _cameraController.value.previewSize;

    return Container(
      constraints: BoxConstraints(
        maxHeight: 500,
        maxWidth: screenW,
      ),
      child: CameraPreview(_cameraController),
    );
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
    print('CARREGOU TFLITE');
  }

  loadCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    print('CARREGOU CAMERAS: ${cameras}');
    return cameras;
  }

  showCamera() {
    if (!_cameraController.value.isInitialized) {
      print('NENHUMA CAMERA INICIALIZADA');
    }

    _cameraController.startImageStream((CameraImage img) async {

      var recognitions = await Tflite.runModelOnFrame(
          bytesList: img.planes.map((plane) {
            return plane.bytes;
          }).toList(), // required
          imageHeight: img.height,
          imageWidth: img.width,
          imageMean: 127.5, // defaults to 127.5
          imageStd: 127.5, // defaults to 127.5
          rotation: 90, // defaults to 90, Android only
          numResults: 2, // defaults to 5
          threshold: 0.1, // defaults to 0.1
          asynch: true // defaults to true
          );
          widget.setRecognitions(recognitions, img.height, img.width);
    });
  }
}
