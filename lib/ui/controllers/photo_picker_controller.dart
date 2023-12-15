import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerController extends GetxController{
  XFile? photo;
  photoPickerField(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(
        children: [
          Text('Chose Your Photo'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SnackBarAction(label: 'Gallery', onPressed: () async{
                final XFile? image = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 50);
                if (image != null) {
                  photo = image;
                  update();
                }
              }),
              SnackBarAction(label: 'Camera', onPressed: () async{
                final XFile? image = await ImagePicker()
                    .pickImage(source: ImageSource.camera, imageQuality: 50);
                if (image != null) {
                  photo = image;
                  update();
                }
              }),
            ],
          )
        ],
      ),
    ));
  }
}