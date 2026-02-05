import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditUserProfilePic extends StatefulWidget {
  const EditUserProfilePic({super.key});

  @override
  State<EditUserProfilePic> createState() => _EditUserProfilePicState();
}

class _EditUserProfilePicState extends State<EditUserProfilePic> {

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectImage;

  Future<void> pickImageFromGallery()async{
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      imageQuality: 80,
    );

    if(image != null){
      _selectImage = File(image.path);
      setState(() {});
    }
  }

  Future<void> pickImageFromCamera()async{
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera,imageQuality: 80);
    if(image != null){
      _selectImage = File(image.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height *  0.23,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (_) =>
                        Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Camera'),
                          onTap: () {
                            pickImageFromCamera();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Gallery'),
                          onTap: () {
                            pickImageFromGallery();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )
                    ,);
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height *  0.08,
                ),
              ),
              IconButton(onPressed:
                  ///save image and pop is image is change or _selectImage is not null
                  (){
                Navigator.pop(context);
                  },
                icon: Icon(
                Icons.done_outline,
                color: Theme.of(
                  context,
                ).colorScheme.primary,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
