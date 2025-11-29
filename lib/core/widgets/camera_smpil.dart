import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _mediaFileList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التصوير',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          iconSize: 35.0,
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          (_mediaFileList??[]).isNotEmpty?
          Center(
            child: SizedBox(
              height: 250,
              width: 250,
              child:  _previewImages(),
            ),
          ):
          Center(
            child: IconButton(
              iconSize: 110.0,
              onPressed: ()
              {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              icon:
              Icon(Icons.camera_alt_outlined),
            ),
          ),
          Text(
            'أرفق الصورة',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _onImageButtonPressed(
      ImageSource source, {
        required BuildContext context,
        bool allowMultiple = false,
        bool isMedia = false,
      }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      setState(() {
        _setImageFileListFromFile(pickedFile);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void _setImageFileListFromFile(XFile? value) {

    _mediaFileList = value == null ? null : <XFile>[value];
  }


  Widget _previewImages() {

    if (_mediaFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: Image.file(
                File(_mediaFileList![index].path),
                errorBuilder:
                    (BuildContext context, Object error, StackTrace? stackTrace) {
                  return const Center(
                    child: Text('This image type is not supported'),
                  );
                },
              ),
            );
          },
          itemCount: _mediaFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text('Pick image error: $_pickImageError', textAlign: TextAlign.center);
    } else {
      return const Text('You have not yet picked an image.', textAlign: TextAlign.center);
    }
  }




}