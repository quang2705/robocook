import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:robocook/displayfood.dart';


class CameraPage extends StatefulWidget {
  final CameraDescription camera;
  final Function addPhotoCallback;

  const CameraPage({Key key, @required this.camera, this.addPhotoCallback}): super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  // Add two variables to the state class to store the CameraController and
  // the Future.
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    // To display the current output from the camera,
    //create a cameraController
    _controller = CameraController(
      //Get a specific camera from the list of available cameras
      widget.camera,
      ResolutionPreset.medium,
    );

    //Next initialize the controller. THis returns a future
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold (
        // You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        body: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview
                    return CameraPreview(_controller);
                  } else {
                    //Otherwise, display a loading indicator
                    return Center(child: CircularProgressIndicator());
                  }
                }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () async {
            try {
              // Ensure that the camera is initialize
              await _initializeControllerFuture;

              //construct the path where the image should be saved using the
              //path package
              final path = join(
                //Store the picture in the temp directory
                //Find the temp directory using the 'path_provider' plugin
                  (await getTemporaryDirectory()).path,
                  '${DateTime.now()}.png',
              );
              await _controller.takePicture(path);
              // If the picture was taken, display it on a new screen.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DisplayFood(imagePath: path,
                          addPhotoCallback: widget.addPhotoCallback),
                ),
              );
            } catch (e) {
              print(e);
            }
          },
        ) ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


