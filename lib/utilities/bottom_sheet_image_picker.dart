import 'package:flutter/material.dart';

class BottomSheets {
  static Future showMultipleImagesPickerBottomSheet(
    BuildContext context,
    void Function()? imagesFromGallery,
    void Function()? imagesFromCamera,
  ) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library,
                    size: 20, color: Colors.black),
                title: const Text(
                  'Photo Library',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: imagesFromGallery,
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  size: 20,
                  color: Colors.black,
                ),
                title:
                    const Text('Camera', style: TextStyle(color: Colors.black)),
                onTap: imagesFromCamera,
              ),
            ],
          ),
        );
      },
    );
  }
}
