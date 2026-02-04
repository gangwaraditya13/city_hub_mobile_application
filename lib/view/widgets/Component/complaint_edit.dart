import 'package:city_hub/data/enums/utility_complaint_type.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_word_limit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PostEdit extends StatefulWidget {
  String? title;
  String? description;
  String? complaintToName;
  String? category;
  String imageUrl;
  PostEdit({required this.imageUrl,required this.title,required this.complaintToName,required this.description,required this.category,super.key});

  @override
  State<PostEdit> createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {

  UtilityComplaintType? selectedUtility;
  late TextEditingController _titleTextEditingController;
  late TextEditingController _descriptionTextEditingController;
  late TextEditingController _complaintToNameTextEditingController;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // reduce size
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


  @override
  void initState() {
  _titleTextEditingController = TextEditingController(text: widget.title);
  _descriptionTextEditingController = TextEditingController(text: widget.description);
  _complaintToNameTextEditingController = TextEditingController(text: widget.complaintToName);
    super.initState();
  }

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _complaintToNameTextEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [Container(
          height: MediaQuery.of(context).size.height * 0.40,
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
                          '${widget.category}',
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onLongPress: (){},
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
                              image: NetworkImage(
                                widget.imageUrl,
                              ),
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
                          child: Container(
                           width: MediaQuery.of(context).size.width * 0.4 ,
                          child: UserInputTextField(
                              textEditingControlleroller: _titleTextEditingController,
                              lableText: "Title",
                              keybordType: TextInputType.text))
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: UserInputTextField(
                                textEditingControlleroller: _complaintToNameTextEditingController,
                                lableText: "Complaint To",
                                keybordType: TextInputType.text))
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: UserInputTextWordLimit(
                        textEditingControlleroller: _descriptionTextEditingController,
                        lableText: "Description",
                        keybordType: TextInputType.text,maxLine: 3,wordLimit: 108,),
                  ),
                )

              ],
            ),
          ),
        ),
          Positioned(
            right:0.0,
            bottom: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                ///save and pop context
                onPressed: () {},
                icon: Icon(
                  Icons.done_outline,
                  color: Theme.of(
                    context,
                  ).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
