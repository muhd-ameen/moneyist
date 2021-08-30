import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormHelper {

  static Widget picPicker(String fileName, Function onFilePicked) {
    Future<PickedFile> _imageFile;
    ImagePicker _picker = new ImagePicker();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: new IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.image, size: 35.0),
                onPressed: () {
                  _imageFile = _picker.getImage(source: ImageSource.gallery);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: new IconButton(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                icon: Icon(Icons.camera, size: 35.0),
                onPressed: () {
                  _imageFile = _picker.getImage(source: ImageSource.camera);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
          ],
        ),
        fileName != null
            ? Image.file(
          File(fileName),
          width: 300,
          height: 300,
        )
            : new Container()
      ],
    );
  }

}
