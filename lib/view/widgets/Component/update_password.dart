import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {

  TextEditingController _oldPasswordtextEditingController = TextEditingController();
  TextEditingController _newPasswordtextEditingController = TextEditingController();
  TextEditingController _reNewPasswordtextEditingController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();

  ValueNotifier<bool> _valueNotifier = ValueNotifier(true);

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _globalKey,
            child: ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (context, value, child) => Column(
                crossAxisAlignment: .end,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: UserInputTextField(
                        textEditingControlleroller: _oldPasswordtextEditingController,
                        lableText: "Old Password",
                        keybordType: TextInputType.text,
                      validator: (value) {
                          if(_oldPasswordtextEditingController.text.isEmpty){
                            return "required";
                          }
                          final passwordRegex = RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                          );

                          if (!passwordRegex.hasMatch(value.toString())) {
                            return 'Password must be at least 8 characters,\ninclude uppercase, lowercase, number and special character';
                          }
                          return null;
                      },
                      obscureText: _valueNotifier.value,
                      suffixIcon: IconButton(onPressed: (){
                        if(_valueNotifier.value){
                          _valueNotifier.value = false;
                        }else{
                          _valueNotifier.value = true;
                        }
                      }, icon: _valueNotifier.value?Icon(Icons.key):Icon(Icons.key_off)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: UserInputTextField(
                        textEditingControlleroller: _newPasswordtextEditingController,
                        lableText: "New Password",
                        keybordType: TextInputType.text,
                      validator: (value) {
                          if(_newPasswordtextEditingController.text.isEmpty){
                            return "required";
                          }
                          if(_newPasswordtextEditingController.text.toString() == _oldPasswordtextEditingController.text.toString()){
                            return "Password match to old password";
                          }
                          if(_newPasswordtextEditingController.text.toString() != _reNewPasswordtextEditingController.text.toString()){
                            return "Password not match";
                          }
                          final passwordRegex = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                        );

                        if (!passwordRegex.hasMatch(value.toString())) {
                          return 'Password must be at least 8 characters,\ninclude uppercase, lowercase, number and special character';
                        }
                          return null;
                      },
                      obscureText: _valueNotifier.value,
                      suffixIcon: IconButton(onPressed: (){
                        if(_valueNotifier.value){
                          _valueNotifier.value = false;
                        }else{
                          _valueNotifier.value = true;
                        }
                      }, icon: _valueNotifier.value?Icon(Icons.key):Icon(Icons.key_off)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: UserInputTextField(
                        textEditingControlleroller: _reNewPasswordtextEditingController,
                        lableText: "New Password",
                        keybordType: TextInputType.text,
                      validator: (value) {
                          if(_reNewPasswordtextEditingController.text.isEmpty){
                            return "required";
                          }
                          if(_newPasswordtextEditingController.text.toString() == _oldPasswordtextEditingController.text.toString()){
                            return "Password match to old password";
                          }
                          if(_newPasswordtextEditingController.text.toString() != _reNewPasswordtextEditingController.text.toString()){
                            return "Password not match";
                          }
                          final passwordRegex = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                        );

                        if (!passwordRegex.hasMatch(value.toString())) {
                          return 'Password must be at least 8 characters,\ninclude uppercase, lowercase, number and special character';
                        }
                          return null;
                      },
                      obscureText: _valueNotifier.value,
                      suffixIcon: IconButton(onPressed: (){
                        if(_valueNotifier.value){
                          _valueNotifier.value = false;
                        }else{
                          _valueNotifier.value = true;
                        }
                      }, icon: _valueNotifier.value?Icon(Icons.key):Icon(Icons.key_off)),
                    ),
                  ),
                  IconButton(onPressed:
                  ///save and pop
                      (){
                    if(_globalKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
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
        ),
      ),
    );
  }
}
