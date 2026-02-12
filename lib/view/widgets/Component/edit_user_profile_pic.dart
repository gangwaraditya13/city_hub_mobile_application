import 'dart:ffi';

import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:city_hub/model_view/image_view_model.dart';
import 'package:city_hub/model_view/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditUserProfilePic extends StatefulWidget {
  const EditUserProfilePic({super.key});

  @override
  State<EditUserProfilePic> createState() => _EditUserProfilePicState();
}

class _EditUserProfilePicState extends State<EditUserProfilePic> {

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectImage;

  late ImageViewModel _imageViewModel;
  late UserViewModel _userViewModel;

  @override
  void initState() {

    _imageViewModel = context.read<ImageViewModel>();
    _userViewModel = context.read<UserViewModel>();

    super.initState();
  }

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

  Future<void> onTapSubmit()async{
    if(_selectImage != null){

      await _imageViewModel.uploadImage(_selectImage!);

      if(_imageViewModel.apiCloudinaryImageResponse!.status == Status.COMPLETED){
        UserModel data = UserModel(
          profilePhotoURL: _imageViewModel.apiCloudinaryImageResponse!.data!.url,
          profileProductId: _imageViewModel.apiCloudinaryImageResponse!.data!.publicId,
        );

        await _userViewModel.updateUserProfilePic(data);

        if(_userViewModel.apiUpdateUserModelProfilePicResponse!.status == Status.COMPLETED){
          Navigator.pop(context);
        }

      }
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
                  foregroundImage: _selectImage != null
                      ? FileImage(_selectImage!)
                      : const NetworkImage("https://media.istockphoto.com/id/2151669184/vector/vector-flat-illustration-in-grayscale-avatar-user-profile-person-icon-gender-neutral.jpg?s=612x612&w=0&k=20&c=UEa7oHoOL30ynvmJzSCIPrwwopJdfqzBs0q69ezQoM8="),
                ),
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) {

                  final response = value.apiUpdateUserModelProfilePicResponse;

                  if (response == null) {
                    return IconButton(
                      onPressed: () => onTapSubmit(),
                      icon: Icon(
                        Icons.done_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }


                  if(response.status == Status.LOADING){
                    return const CircularProgressIndicator();
                  }

                  if(response.status == Status.ERROR){
                    return Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text("something went wrong",style: TextStyle(color: Colors.red),),
                        IconButton(onPressed: () => onTapSubmit(),
                          icon: Icon(
                            Icons.done_outline,
                            color: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),),
                      ],
                    );
                  }

                  return IconButton(onPressed: () => onTapSubmit(),
                    icon: Icon(
                      Icons.done_outline,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary,
                    ),);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
