import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:city_hub/model_view/user_view_model.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  late UserViewModel _userViewModel;

  ValueNotifier<bool> _valueNotifier = ValueNotifier(true);


  @override
  void initState() {
    _userViewModel = context.read<UserViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  Future<void> _onTapSubmit(UserViewModel value)async{
    if(_globalKey.currentState!.validate()) {
      UserModel data = UserModel(
        password: _oldPasswordtextEditingController.text.trim(),
        newPassword: _newPasswordtextEditingController.text.trim()
      );

      await value.updateUserPassword(data);

      if(value.apiUpdateUserModelPasswordResponse?.status == Status.COMPLETED) {
        Navigator.pop(context);
      }
    }
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
                  Consumer<UserViewModel>(
                    builder: (context, value, child) {

                      if(value.apiUpdateUserModelPasswordResponse?.status == Status.LOADING){
                        return const CircularProgressIndicator();
                      }

                      if(value.apiUpdateUserModelPasswordResponse?.status == Status.ERROR){
                        return Row(
                          children: [
                            Text("Some thing went wrong", style: TextStyle(color: Colors.red),),
                            IconButton(
                              ///save and pop
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
                      ///save and pop
                        onPressed: () => _onTapSubmit(value),
                        icon: Icon(
                          Icons.done_outline,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary,
                        ),);
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
