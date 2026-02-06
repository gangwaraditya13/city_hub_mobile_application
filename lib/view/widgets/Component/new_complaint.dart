import 'dart:io';

import 'package:city_hub/data/enums/utility_complaint_type.dart';
import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model/user_complaint_model.dart';
import 'package:city_hub/model_view/home_view_model.dart';
import 'package:city_hub/model_view/image_view_model.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_word_limit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewComplaint extends StatefulWidget {
  const NewComplaint({super.key});

  @override
  State<NewComplaint> createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {


  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _complaintToNameTextEditingController = TextEditingController();

  File? _selectedImage;
  UtilityComplaintType? selectedUtility;

  ImagePicker _imagePicker = ImagePicker();

  late ImageViewModel _imageViewModel;
  late HomeViewModel _homeViewModel;

  final GlobalKey<FormState> _globalKeyTitle = GlobalKey();
  final GlobalKey<FormState> _globalKeyDescription = GlobalKey();


  Future<void> _pickImageFromGallery()async{
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if(image != null){
      _selectedImage = File(image.path);
      setState(() {});
    }
  }

  Future<void> _pickImageFromCamera()async{
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);

    if(image != null){
      _selectedImage = File(image.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageViewModel = context.read<ImageViewModel>();
    _homeViewModel = context.read<HomeViewModel>();
    super.initState();
  }

  Future<void> _onTapSubmit(HomeViewModel value)async{

    if (selectedUtility == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a utility"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if(_globalKeyTitle.currentState!.validate() && _globalKeyDescription.currentState!.validate()) {
      if (_selectedImage == null) {
        UserComplaintModel data = UserComplaintModel(
          complaintTitle: _titleTextEditingController.text.trim(),
          complaintToName: _complaintToNameTextEditingController.text.trim(),
          complaintDescription: _descriptionTextEditingController.text.trim(),
          complaintCategory: selectedUtility!.name,
        );

        await value.newComplaint(data);

        if (value.apiNewComplaintResponse?.status == Status.COMPLETED) {
          Navigator.pop(context);
        }
      }
      else {
        await _imageViewModel.uploadImage(_selectedImage!);

        if (_imageViewModel.apiCloudinaryImageResponse?.status ==
            Status.COMPLETED) {
          UserComplaintModel data = UserComplaintModel(
            complaintTitle: _titleTextEditingController.text.trim(),
            complaintToName: _complaintToNameTextEditingController.text.trim(),
            complaintDescription: _descriptionTextEditingController.text.trim(),
            complaintCategory: selectedUtility.toString(),
            profilePhotoURL: _imageViewModel.apiCloudinaryImageResponse!.data!
                .url,
            profileProductId: _imageViewModel.apiCloudinaryImageResponse!.data!
                .publicId,
          );

          await value.newComplaint(data);

          if (value.apiNewComplaintResponse?.status == Status.COMPLETED) {
            Navigator.pop(context);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.41,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<UtilityComplaintType>(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 4,
                          value: selectedUtility,
                          hint: Text(
                            'select Utility',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          items: UtilityComplaintType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.name,style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedUtility = value;
                            });
                          },
                        ),
                      ),

                    ],
                  ),
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
                                        _pickImageFromGallery();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Camera'),
                                      onTap: () {
                                        _pickImageFromCamera();
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
                                      :NetworkImage("https://imgs.search.brave.com/7PhHNvqYShphnIgWBlWDtBp2tYpkl8Cxx5gu_QZgVWw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9wcm9v/ZmVkLmNvbS93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMS8xMC83/LUdyYXBoaWMtV29y/ZC1DaG9pY2UtQ29t/cGxhY2VudC12cy4t/Q29tcGxhaXNhbnQu/cG5n"),
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
              child: Consumer<HomeViewModel>(
                builder: (context, value, child) {
                  if(value.apiNewComplaintResponse?.status == Status.LOADING){
                    return Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    );
                  }

                  if(value.apiNewComplaintResponse?.status == Status.ERROR){
                    return IconButton(
                      ///save and pop context
                      onPressed: () => _onTapSubmit(value),
                      icon: Row(
                        mainAxisAlignment: .end,
                        children: [
                          Text("some thing went wrong",style: TextStyle(color: Colors.red),),
                          Icon(
                            Icons.done_outline,
                            color: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        ],
                      ),
                    );
                  }

                  return IconButton(
                    ///save and pop context
                    onPressed: () => _onTapSubmit(value),
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
