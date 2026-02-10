import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/data/services/token_storage.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:city_hub/model_view/user_view_model.dart';
import 'package:city_hub/view/widgets/Component/custom_text_buton.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {

  late UserViewModel _userViewModel;
  late TokenStorage _tokenStorage;

  @override
  void initState() {
    _userViewModel = context.read<UserViewModel>();
    _tokenStorage = TokenStorage();
    super.initState();
  }

  TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  ValueNotifier<bool> _valueNotifier = ValueNotifier(true);

  ///apply functionality
  Future<void> onTapConform(String password)async{
    UserModel data = UserModel(
      password: password
    );

    await _userViewModel.deleteUserPermanently(data);

    if(_userViewModel.apiUserDeletePermanentResponse!.status == Status.COMPLETED){
      _tokenStorage.clear();
      Navigator.pushReplacementNamed(context, "login_view");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// PASSWORD FIELD
            Form(
              key: _globalKey,
              child: ValueListenableBuilder(
                valueListenable: _valueNotifier,
                builder: (_, value, __) {
                  return UserInputTextField(
                    textEditingControlleroller: _passwordTextEditingController,
                    lableText: "Password",
                    keybordType: TextInputType.text,
                    obscureText: value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(value ? Icons.key : Icons.key_off),
                      onPressed: () =>
                      _valueNotifier.value = !_valueNotifier.value,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Consumer<UserViewModel>(
              builder: (context, vm, _) {
                final response = vm.apiUserDeletePermanentResponse;

                if (response?.status == Status.COMPLETED) {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await TokenStorage().clear();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "login_view",
                          (_) => false,
                    );
                  });
                }

                if (response?.status == Status.ERROR) {
                  return Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        response!.message ?? "Delete failed",
                        style: const TextStyle(color: Colors.red),
                      ),
                      CustomTextButton(
                        isLoading: response?.status == Status.LOADING,
                        onTap: response?.status == Status.LOADING
                            ? null
                            : () {
                          if (_globalKey.currentState!.validate()) {
                            vm.deleteUserPermanently(
                              UserModel(
                                password: _passwordTextEditingController.text.trim(),
                              ),
                            );
                          }
                        },
                        widget: const Icon(Icons.refresh),
                      )
                    ],
                  );
                }

                return CustomTextButton(
                  isLoading: response?.status == Status.LOADING,
                  onTap: response?.status == Status.LOADING
                      ? null
                      : () {
                    if (_globalKey.currentState!.validate()) {
                      vm.deleteUserPermanently(
                        UserModel(
                          password: _passwordTextEditingController.text.trim(),
                        ),
                      );
                    }
                  },
                  widget: const Text("Confirm Delete"),
                );
              },
            ),
          ],
        ),
      ),
    );

  }
}
