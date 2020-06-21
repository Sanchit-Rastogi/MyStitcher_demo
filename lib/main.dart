import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _frontImage;
  File _sideImage;
  final picker = ImagePicker();
  bool pickedFront = false;
  bool pickedSide = false;

  Future getFrontImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _frontImage = File(pickedFile.path);
      pickedFront = true;
    });
  }

  Future getSideImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _sideImage = File(pickedFile.path);
      pickedSide = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyStitcher Demo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: pickedFront
                    ? Container(
                        child: Image.file(_frontImage),
                        height: 300,
                        width: 300,
                      )
                    : Icon(
                        Icons.image,
                        size: 300,
                      ),
              ),
              Container(
                child: pickedSide
                    ? Container(
                        child: Image.file(_sideImage),
                        height: 300,
                        width: 300,
                      )
                    : Icon(
                        Icons.image,
                        size: 300,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: getFrontImage,
                    child: Text('Front Image'),
                  ),
                  RaisedButton(
                    onPressed: getSideImage,
                    child: Text('Side Image'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
