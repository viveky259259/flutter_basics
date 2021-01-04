import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args){
  runApp(ImagePickerApp());
}

class ImagePickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Example',
      home: ImagePickerExample(),
    );
  }
}

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File image;
  File newImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image picker'),
      ),
      body: Column(
        children: [
          newImage == null ? Text('Select a image') : Image.file(image),
          Row(
            children: [
              FlatButton(
                  onPressed: () {
                    ImagePicker()
                        .getImage(source: ImageSource.gallery)
                        .then((value) async {
                      image = File(value.path);
                      print(image.path);
                      final String path =
                          (await getExternalStorageDirectories()).first.path;
                      print('Path: $path');
                      await image.copy('$path/newImage.jpg').then((value) {
                        newImage = value;
                        print('Image Saved: $value');
                        newImage.create();
                        setState(() {});
                      });
                    });
                  },
                  child: Text('Select ')),
              FlatButton(
                  onPressed: () async {
                    print(image.path);
                    final String path =
                        (await getApplicationDocumentsDirectory()).path;
                    final File newImage =
                        await image.copy('$path/imagexxxx.jpg').then((value) {
                      print('Image Saved');
                    });
                  },
                  child: Text('Save')),
            ],
          )
        ],
      ),
    );
  }
}
