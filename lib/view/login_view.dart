import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model/login_request_model.dart';
import 'package:city_hub/model_view/login_view_model.dart';
import 'package:city_hub/utils/flash_bar.dart';
import 'package:city_hub/view/widgets/Component/custom_text_buton.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<LoginViewModel>();
  }

  ValueNotifier<bool> _valueNotifier = ValueNotifier(true);

  TextEditingController _emailTextEditiongController = TextEditingController();
  TextEditingController _passwordTextEditiongController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                UserInputTextField(
                  textEditingControlleroller: _emailTextEditiongController,
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
                    textEditingControlleroller: _passwordTextEditiongController,
                    lableText: "Password",
                    keybordType: .emailAddress,
                    obscureText: value,
                    suffixIcon: IconButton(onPressed: (){
                      if(_valueNotifier.value){
                        _valueNotifier.value = false;
                      }else{
                        _valueNotifier.value = true;
                      }
                    },
                        icon: Icon(value ?Icons.key: Icons.key_off)),
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
                      return null;
                    },
                  ),
                ),
                SizedBox.square(dimension: 20),
                Row(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    Consumer<LoginViewModel>(
                      builder: (context, value, child) {

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (value.loginResponse?.status == Status.COMPLETED) {
                            Navigator.pushReplacementNamed(context, "home_view");
                          }

                          if (value.loginResponse?.status == Status.ERROR) {
                            FlashBar.flushBarErrorMessage(
                              value.loginResponse!.message!,
                              context,
                            );
                          }
                        });

                        final isLoading = value.loginResponse?.status == Status.LOADING;
                        return CustomTextButton(
                          onTap:isLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              LoginRequestModel loginRequestModel =
                                  LoginRequestModel(
                                    email: _emailTextEditiongController.text
                                        .toString().trim(),
                                    password: _passwordTextEditiongController
                                        .text
                                        .toString().trim(),
                                  );

                              if (kDebugMode) {
                                print(loginRequestModel.toJson());
                              }

                              value.login(loginRequestModel);
                            }
                          },
                          widget: isLoading
                              ? CircularProgressIndicator(backgroundColor: Theme.of(context).colorScheme.secondary,)
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),
                          isLoading: isLoading,
                        );
                      },
                    ),
                    SizedBox.square(dimension: 20),
                    CustomTextButton(
                      widget: Text(
                        "Signup",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "signup_view");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
