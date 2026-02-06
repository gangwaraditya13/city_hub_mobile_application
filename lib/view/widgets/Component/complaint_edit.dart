import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model/user_complaint_model.dart';
import 'package:city_hub/model_view/image_view_model.dart';
import 'package:city_hub/model_view/user_view_model.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_word_limit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostEdit extends StatefulWidget {
  String? title;
  String? description;
  String? complaintToName;
  String? category;
  String? imageUrl;
  String? imageId;
  String? complaintId;
  PostEdit({this.complaintId, required this.imageUrl,this.imageId,required this.title,required this.complaintToName,required this.description,required this.category,super.key});

  @override
  State<PostEdit> createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {

  late TextEditingController _titleTextEditingController;
  late TextEditingController _descriptionTextEditingController;
  late TextEditingController _complaintToNameTextEditingController;
  late UserViewModel _userViewModel;
  late ImageViewModel _imageViewModel;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _submitUpdate(UserViewModel value)async{
    if(_selectedImage != null){
        ///uploading image
        await _imageViewModel.uploadImage(_selectedImage!);
        if (_imageViewModel.apiCloudinaryImageResponse!
            .status == Status.COMPLETED) {
          UserComplaintModel dataWithImage = UserComplaintModel(
            profileProductId: _imageViewModel
                .apiCloudinaryImageResponse!.data!.publicId,
            profilePhotoURL: _imageViewModel
                .apiCloudinaryImageResponse!.data!.url,
            complaintTitle: _titleTextEditingController.text
                .trim().toString(),
            complaintDescription: _descriptionTextEditingController
                .text.trim().toString(),
            sId: widget.complaintId,
          );

          await value.updateUserComplaint(dataWithImage);

          if (value.apiUpdateUserComplaintResponse?.status ==
              Status.COMPLETED) {
            Navigator.pop(context);
          }
        }
    }
    if(_selectedImage == null && _globalKeyTitle.currentState!.validate() && _globalKeyDescription.currentState!.validate()){
      if(_titleTextEditingController.text.trim().toString() == widget.title && _descriptionTextEditingController.text.trim().toString() == widget.description){
        Navigator.pop(context);
      }
      else {
        UserComplaintModel dataNotImage = UserComplaintModel(
          profileProductId: widget.imageId,
          profilePhotoURL: widget.imageUrl,
          complaintTitle: _titleTextEditingController.text
              .trim(),
          complaintDescription: _descriptionTextEditingController
              .text.trim(),
          sId: widget.complaintId,
        );

        await value.updateUserComplaint(dataNotImage);

        if (value.apiUpdateUserComplaintResponse?.status ==
            Status.COMPLETED) {
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  void initState() {
  _titleTextEditingController = TextEditingController(text: widget.title);
  _descriptionTextEditingController = TextEditingController(text: widget.description);
  _complaintToNameTextEditingController = TextEditingController(text: widget.complaintToName);
  _userViewModel = context.read<UserViewModel>();
  _imageViewModel = context.read<ImageViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _complaintToNameTextEditingController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _globalKeyTitle = GlobalKey();
  final GlobalKey<FormState> _globalKeyDescription = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [

          Container(
          height: MediaQuery.of(context).size.height * 0.36,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onLongPress: (){
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.photo_library),
                                    title: Text('Gallery'),
                                    onTap: () {
                                      pickImageFromGallery();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.camera_alt),
                                    title: Text('Camera'),
                                    onTap: () {
                                      pickImageFromCamera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            height:
                            MediaQuery.of(
                              context,
                            ).size.height *
                                0.11,
                            width:
                            MediaQuery.of(
                              context,
                            ).size.width *
                                0.3,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(12),
                              image: DecorationImage(
                                image: _selectedImage != null
                                    ? FileImage(_selectedImage!) as ImageProvider
                                    :(widget.imageUrl!.isNotEmpty
                                    ? NetworkImage(widget.imageUrl!)
                                    : NetworkImage("https://imgs.search.brave.com/7PhHNvqYShphnIgWBlWDtBp2tYpkl8Cxx5gu_QZgVWw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9wcm9v/ZmVkLmNvbS93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMS8xMC83/LUdyYXBoaWMtV29y/ZC1DaG9pY2UtQ29t/cGxhY2VudC12cy4t/Q29tcGxhaXNhbnQu/cG5n")),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            child: Form(
                              key: _globalKeyTitle,
                              child: Container(
                               width: MediaQuery.of(context).size.width * 0.4 ,
                              child: UserInputTextField(
                                  textEditingControlleroller: _titleTextEditingController,
                                  lableText: "Title",
                                  keybordType: TextInputType.text,
                                validator: (value) {
                                    if(_titleTextEditingController.text.isEmpty){
                                      return "required";
                                    }
                                  return null;
                                },
                              )
                              ),
                            )
                          ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: UserInputTextField(
                                    textEditingControlleroller: _complaintToNameTextEditingController,
                                    lableText: "Complaint To",
                                    keybordType: TextInputType.text,

                                )
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Form(
                    key: _globalKeyDescription,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: UserInputTextWordLimit(
                          textEditingControlleroller: _descriptionTextEditingController,
                          lableText: "Description",
                          keybordType: TextInputType.text,maxLine: 3,wordLimit: 108,
                          validator: (value) {
                            if(_descriptionTextEditingController.text.isEmpty){
                              return "required";
                            }
                            return null;
                          },
                        ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
          Consumer<ImageViewModel>(
            builder: (context, value, child) {

              if (value.apiCloudinaryImageResponse == null) {
                return const SizedBox();
              }

              ///uploading image progress
              if(value.apiCloudinaryImageResponse!.status == Status.COMPLETED){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                );
              }
              if(value.apiCloudinaryImageResponse!.status == Status.ERROR){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: Center(child: Text("Oops Image not load..")),
                );
              }
              return  Container(
                height: MediaQuery.of(context).size.height * 0.36,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          Positioned(
            right:0.0,
            bottom: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Consumer<UserViewModel>(
                builder: (context, value, child) {

                  if(value.apiUpdateUserComplaintResponse?.status == Status.LOADING){
                    return CircularProgressIndicator();
                  }
                  if(value.apiUpdateUserComplaintResponse?.status == Status.ERROR){
                    return Row(
                      children: [
                        Text("Some thing went wrong", style: TextStyle(color: Colors.red),),
                        IconButton(
                          ///retry and pop context
                          onPressed: () => _submitUpdate(value),
                          icon: Icon(
                            Icons.refresh,
                            color: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        )
                      ],
                    );
                  }
                  return IconButton(
                    ///save and pop context
                    onPressed: () => _submitUpdate(value),
                    icon: Icon(
                      Icons.done_outline,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
