import 'package:city_hub/model_view/signup_view_model.dart';
import 'package:city_hub/view/widgets/Component/custom_text_buton.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupView2 extends StatefulWidget {
  const SignupView2({super.key});

  @override
  State<SignupView2> createState() => _SignupView2State();
}

class _SignupView2State extends State<SignupView2> {

  ValueNotifier<bool> _valueNotifier = ValueNotifier(true);
  ValueNotifier<bool> _valueNotifier1 = ValueNotifier(true);

  late SignupViewModel _viewModel;

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _password1TextEditingController = TextEditingController();
  TextEditingController _password2TextEditingController = TextEditingController();

  ///profilePhotoUrl
  ///profileProductId

  @override
  void initState() {
    _viewModel = context.read<SignupViewModel>();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Wrap(
                alignment: .center,
                crossAxisAlignment: .center,
                children: [
                  UserInputTextField(
                    textEditingControlleroller: _emailTextEditingController,
                    lableText: "Email",
                    keybordType: .emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }

                      final emailRegex = RegExp(
                        r'^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox.square(dimension: 20),
                  ValueListenableBuilder(
                    valueListenable: _valueNotifier,
                    builder: (context, value, child) => UserInputTextField(
                      textEditingControlleroller: _password1TextEditingController,
                      lableText: "Password",
                      keybordType: .emailAddress,
                      obscureText: value,
                      suffixIcon: IconButton(onPressed: (){
                        if(_valueNotifier.value){
                          _valueNotifier.value =false;
                        }else{
                          _valueNotifier.value = true;
                        }
                      }, icon: Icon(_valueNotifier.value ?Icons.key: Icons.key_off)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        final passwordRegex = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                        );

                        if (!passwordRegex.hasMatch(value)) {
                          return 'Password must be at least 8 characters,\ninclude uppercase, lowercase, number and special character';
                        }
                        if(_password1TextEditingController.text.toString() != _password2TextEditingController.text.toString()){
                          return 'Password are not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox.square(dimension: 20),
                  ValueListenableBuilder(
                    valueListenable: _valueNotifier1,
                    builder: (context, value, child) => UserInputTextField(
                      textEditingControlleroller: _password2TextEditingController,
                      lableText: "RePassword",
                      keybordType: .emailAddress,
                      obscureText: value,
                      suffixIcon: IconButton(onPressed: (){
                        if(_valueNotifier1.value){
                          _valueNotifier1.value = false;
                        }else{
                          _valueNotifier1.value = true;
                        }
                      },
                          icon: Icon(_valueNotifier1.value ?Icons.key: Icons.key_off)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        final passwordRegex = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                        );

                        if (!passwordRegex.hasMatch(value)) {
                          return 'Password must be at least 8 characters,\ninclude uppercase, lowercase, number and special character';
                        }
                        if(_password1TextEditingController.text.toString() != _password2TextEditingController.text.toString()){
                          return 'Password are not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  Consumer<SignupViewModel>(
                    builder: (context, value, child) =>  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextButton(
                        widget: Text(
                          "Next",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        onTap: () {
                          if(_formKey.currentState!.validate()) {
                            value.userFlowModel.email = _emailTextEditingController.text.toString();
                            value.userFlowModel.password = _password1TextEditingController.text.toString();
                            value.userFlowModel.profilePhotoURL = "https://res.cloudinary.com/dx3wtw7pf/image/upload/v1756753309/def_profile_pic_nu8tlc.png";
                            value.userFlowModel.profileProductId = "";
                            Navigator.pushNamed(context, "signup3_view");
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
