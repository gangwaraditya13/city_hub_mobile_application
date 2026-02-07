import 'package:city_hub/view/widgets/Component/custom_text_buton.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {

  TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  ValueNotifier<bool> _valueNotifier = ValueNotifier(true);

  ///apply functionality
  Future<void> onTapConform(String password)async{
    Navigator.pop(context);
    Navigator.pop(context);
    // Navigator.pushReplacementNamed(context, "login_view");
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height/7,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: _valueNotifier,
                builder: (context, value, child) => UserInputTextField(
                    textEditingControlleroller: _passwordTextEditingController,
                    lableText: "Password",
                    keybordType: TextInputType.text,
                  validator: (value) {
                    if(_passwordTextEditingController.text.isEmpty){
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
              IconButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context) => Dialog(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: CustomTextButton(
                          onTap: () => onTapConform(_passwordTextEditingController.text.trim()),
                          widget:
                          Text("Conform",style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
                      ),
                    ),);
                  },
                  icon: Icon(Icons.done_outline))
            ],
          ),
        ),
      ),
    );
  }
}
