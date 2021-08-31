import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stamp_image/stamp_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stamp Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();
  File? image;

  void takePicture() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await resetImage();

      StampImage.create(
        context: context,
        image: File(pickedFile.path),
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: _watermarkItem(),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: _logoFlutter(),
          )
        ],
        onSuccess: (file) => resultStamp(file),
      );
    }
  }

  ///Resetting an image file
  Future resetImage() async {
    setState(() {
      image = null;
    });
  }

  ///Handler when stamp image complete
  void resultStamp(File? file) {
    print(file?.path);
    setState(() {
      image = file;
    });
  }

  Widget _watermarkItem() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            DateTime.now().toString(),
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          SizedBox(height: 5),
          Text(
            "Made By Stamp Image",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoFlutter() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FlutterLogo(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stamp Imager"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageWidget(),
            SizedBox(height: 10),
            _buttonTakePicture()
          ],
        ),
      ),
    );
  }

  Widget _buttonTakePicture() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => takePicture(),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          "Take Picture",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: image != null ? Image.file(image!) : SizedBox(),
    );
  }
}
