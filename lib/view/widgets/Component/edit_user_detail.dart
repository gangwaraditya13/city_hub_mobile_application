import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:city_hub/model_view/user_view_model.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserDetail extends StatefulWidget {

  String? name;
  String? email;
  String? phone;
  String? address;

  EditUserDetail({required this.name, required this.email,required this.phone, required this.address, super.key});

  @override
  State<EditUserDetail> createState() => _EditUserDetailState();
}

class _EditUserDetailState extends State<EditUserDetail> {

  late TextEditingController _nameTextEditingController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _phoneTextEditingController;
  late TextEditingController _addressTextEditingController;
  final GlobalKey<FormState> _globalKey = GlobalKey();
  late UserViewModel _userViewModel;

  @override
  void initState() {

    _nameTextEditingController = TextEditingController(text: widget.name);
    _emailTextEditingController = TextEditingController(text: widget.email);
    _phoneTextEditingController = TextEditingController(text: widget.phone);
    _addressTextEditingController = TextEditingController(text: widget.address);
    _userViewModel = context.read<UserViewModel>();

    super.initState();
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _addressTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _onTapSubmit(UserViewModel value)async{
    if(_globalKey.currentState!.validate()){

      if(_nameTextEditingController.text.trim() != widget.name
          || _emailTextEditingController.text.trim() != widget.email
          || _phoneTextEditingController.text.trim() != widget.phone
          || _addressTextEditingController.text.trim() != widget.address){

        UserModel data = UserModel(
            name: _nameTextEditingController.text.trim(),
            email: _emailTextEditingController.text.trim(),
            phone: _phoneTextEditingController.text.trim(),
            address: _addressTextEditingController.text.trim()
        );

        await value.updateUserDetails(data);

        if(value.apiUpdateUserModelResponse?.status == Status.COMPLETED){
          Navigator.pop(context);
        }
      }else{
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.49,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: UserInputTextField(textEditingControlleroller: _nameTextEditingController,
                      lableText: "Name",
                      keybordType: TextInputType.text,
                    validator: (value) {
                      if(_nameTextEditingController.text.isEmpty){
                        return "Name is empty";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: UserInputTextField(textEditingControlleroller: _emailTextEditingController,
                    lableText: "Email",
                    keybordType: TextInputType.text,
                    validator: (value) {
                      if(_emailTextEditingController.text.isEmpty){
                        return "Email is empty";
                      }
                      final emailRegex = RegExp(
                        r'^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$',
                      );
                      if (!emailRegex.hasMatch(value.toString())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: UserInputTextField(textEditingControlleroller: _phoneTextEditingController,
                      lableText: "Phone Number",
                      keybordType: TextInputType.phone,
                    validator: (value) {
                      if(_phoneTextEditingController.text.isEmpty){
                        return "Phone Number is empty";
                      }
                      final phoneRegex = RegExp(
                        r'^(?:\+91|0)?[6-9]\d{9}$',
                      );

                      if (!phoneRegex.hasMatch(value.toString())) {
                        return 'Enter a valid Indian phone number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: UserInputTextField(textEditingControlleroller: _addressTextEditingController,
                      lableText: "Address",
                      keybordType: TextInputType.text,
                    validator: (value) {
                      if(_addressTextEditingController.text.isEmpty){
                        return "Address is empty";
                      }
                      return null;
                    },
                  ),
                ),
                Consumer<UserViewModel>(
                  builder: (context, value, child) {

                    if(value.apiUpdateUserModelResponse?.status == Status.LOADING){
                      return const CircularProgressIndicator();
                    }
                    if(value.apiUpdateUserModelResponse?.status == Status.ERROR){
                      return Row(
                        mainAxisAlignment: .end,
                        children: [
                          Text("Some thing went wrong",style: TextStyle(color: Colors.red),),
                          IconButton(
                            ///save and pop context
                            onPressed: () => _onTapSubmit(value),
                            icon: Icon(
                              Icons.refresh,
                              color: Theme.of(
                                context,
                              ).colorScheme.primary,
                            ),),
                        ],
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
                    ),);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
