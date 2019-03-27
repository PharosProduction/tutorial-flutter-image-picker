import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PickerPage(title: 'Tutorial image picker'),
    );
  }
}

class PickerPage extends StatefulWidget {
  PickerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PickerPageState createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  File _cameraFile;
  File _galleryFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 24.0)),
          _buildCameraPictureHolder(),
          Text('Camera Image'),
          _buildGalleryPictureHolder(),
          Text('Gallery Image'),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _buildCameraButton(),
              _buildGalleryButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCameraPictureHolder() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.lime), borderRadius: BorderRadius.zero),
      child: (_cameraFile != null) ? Image.file(_cameraFile, fit: BoxFit.cover) : Icon(Icons.hourglass_empty),
      height: 200,
      width: 200,
    );
  }

  Widget _buildGalleryPictureHolder() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.lime), borderRadius: BorderRadius.zero),
      child: (_galleryFile != null)
          ? Image.file(
              _galleryFile,
              fit: BoxFit.cover,
            )
          : Icon(Icons.hourglass_empty),
      height: 200,
      width: 200,
    );
  }

  Widget _buildCameraButton() {
    return Expanded(
      child: RaisedButton(
        child: Text('Camera Image'),
        onPressed: () {
          _takeCameraPicture();
        },
      ),
    );
  }

  Widget _buildGalleryButton() {
    return Expanded(
      child: RaisedButton(
        child: Text("Gallery Image"),
        onPressed: () {
          _takeGalleryPicture();
        },
      ),
    );
  }

  void _takeGalleryPicture() async {
    var galleryFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _galleryFile = galleryFile;
    });
  }

  void _takeCameraPicture() async {
    var cameraFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _cameraFile = cameraFile;
    });
  }
}
