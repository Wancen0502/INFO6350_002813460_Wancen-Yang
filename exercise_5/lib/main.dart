import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  runApp(MyApp(cameras:cameras));
}

class MyApp extends StatelessWidget{

  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.cameras}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Camera App Demo',
      theme:ThemeData(primarySwatch: Colors.lightBlue),
      home: CameraScreen(title:'Camera App Demo',cameras:cameras ),
    );
  }

}

class CameraScreen extends StatefulWidget{

  final List<CameraDescription> cameras;

  const CameraScreen({Key? key, required this.title, required this.cameras}):super(key:key);

  final String title;

  @override
  State<CameraScreen> createState()=>_CameraScreenState();

}

class _CameraScreenState extends State<CameraScreen>{

  late CameraController _controller;
  late Future<void> _initializeContollerFuture;
  bool _isCameraReady = false;
  int selectedCamera = 0;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[selectedCamera], ResolutionPreset.medium);
    _initializeContollerFuture = _controller.initialize().then((_){
      setState(() {
        _isCameraReady = true;
      });
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void _takePicture() async{
    try{
      await _initializeContollerFuture;
      final image = await _controller.takePicture();

      if (!context.mounted) return;

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => DisplayPictureScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: image.path,
          ),
        ),
      );
    }catch(e){
      print('Error while taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title:Text(widget.title),
        ),
        body: FutureBuilder<void>(
            future: _initializeContollerFuture,
            builder:(context,snapshot){
              if(snapshot.connectionState==ConnectionState.done && _isCameraReady){
                return ListView( children:[
                  CameraPreview(_controller),
                  Expanded(child:
                  Container(
                      color:Colors.black,
                      child:Row(mainAxisAlignment: MainAxisAlignment.center, children:[
                        ElevatedButton(
                          onPressed: _takePicture,
                          child:Icon(Icons.circle, size: 10),

                        )
                      ],)
                  ))
                ]);
              }else{
                return Center(child: CircularProgressIndicator());
              }

            }

        )

    );

  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
        child: kIsWeb
            ? Image.network(imagePath)
            : Image.file(File(imagePath)),
      ),
    );
  }
}
