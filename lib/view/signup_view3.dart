import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:city_hub/model_view/signup_view_model.dart';
import 'package:city_hub/utils/flash_bar.dart';
import 'package:city_hub/view/widgets/Component/custom_text_buton.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupView3 extends StatefulWidget {
  const SignupView3({super.key});

  @override
  State<SignupView3> createState() => _SignupView3State();
}

class _SignupView3State extends State<SignupView3> {
  late SignupViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<SignupViewModel>();
  }

  String? selectedCity;
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Consumer<SignupViewModel>(

          builder: (context, values, child) {

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (values.signupResponse?.status == Status.COMPLETED) {
                Navigator.pushReplacementNamed(context, "login_view");
              }

              if (values.signupResponse?.status == Status.ERROR) {
                FlashBar.flushBarErrorMessage(
                  values.signupResponse!.message.toString(),
                  context,
                );
              }
            });

            final isLoading = values.signupResponse?.status == Status.LOADING;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserInputTextField(
                  textEditingControlleroller: _cityController,
                  lableText: "City",
                  keybordType: TextInputType.text,
                  onChange: (value) {
                    if (value.length < 2) {
                      values.clearSuggestions();
                      return;
                    }
                    values.searchCity(value);
                  },
                ),
                Container(
                  height: values.suggestions.isEmpty
                      ? 0.0
                      : MediaQuery.of(context).size.height / 4.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: values.suggestions.length,
                    itemBuilder: (context, index) {
                      final city = values.suggestions[index];
                      return ListTile(
                        title: Text(city),
                        onTap: () {
                          selectedCity = city;
                          _cityController.text = city;
                          values.clearSuggestions();
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextButton(
                    isLoading: isLoading,
                    widget:
                    values.signupResponse?.status == Status.LOADING ?
                    CircularProgressIndicator(backgroundColor: Theme.of(context).colorScheme.surface ,) :
                    Text(
                      "done",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onTap: isLoading? null: () {
                      values.userFlowModel.city = _cityController.text.toString();
                      UserModel user = UserModel(
                        name: values.userFlowModel.name,
                        phone: values.userFlowModel.phone,
                        idProof: values.userFlowModel.idProof,
                        address: values.userFlowModel.address,
                        email: values.userFlowModel.email,
                        password: values.userFlowModel.password,
                        profilePhotoURL: values.userFlowModel.profilePhotoURL,
                        profileProductId: values.userFlowModel.profileProductId,
                        city: values.userFlowModel.city
                      );
                      values.signUp(user);
                    },
                  ),
                ),
              ],
            );},
          ),
        ),
      ),
    );
  }
}
