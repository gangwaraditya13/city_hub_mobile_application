import 'package:city_hub/model_view/signup_view_model.dart';
import 'package:city_hub/view/widgets/Component/custom_text_buton.dart';
import 'package:city_hub/view/widgets/Component/user_input_text_feald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _phoneTextEditingController = TextEditingController(text: "+91");
  TextEditingController _idProofTextEditingController = TextEditingController();
  TextEditingController _addressTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SignupViewModel _viewModel;

  @override
  void initState() {
    _viewModel = context.read<SignupViewModel>();
    super.initState();
  }

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
                    textEditingControlleroller: _nameTextEditingController,
                    lableText: "Name",
                    keybordType: .emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox.square(dimension: 20),
                  UserInputTextField(
                    textEditingControlleroller: _phoneTextEditingController,
                    lableText: "Phone Number",
                    keybordType: .emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number is required';
                      }

                      final phoneRegex = RegExp(
                        r'^(?:\+91|0)?[6-9]\d{9}$',
                      );

                      if (!phoneRegex.hasMatch(value)) {
                        return 'Enter a valid Indian phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox.square(dimension: 20),
                  UserInputTextField(
                    textEditingControlleroller: _idProofTextEditingController,
                    lableText: "Aadhaar Number",
                    keybordType: .emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Aadhaar Number is required';
                      }

                      final aadhaarRegex = RegExp(
                        r'^[2-9]{1}[0-9]{3}\s?[0-9]{4}\s?[0-9]{4}$',
                      );

                      if (!aadhaarRegex.hasMatch(value)) {
                        return 'Enter a valid Aadhaar number';
                      }
                      return null;
                    },
                  ),
                  SizedBox.square(dimension: 20),
                  UserInputTextField(
                    textEditingControlleroller: _addressTextEditingController,
                    lableText: "Address",
                    keybordType: .emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }

                      return null;
                    },
                  ),
                  SizedBox.square(dimension: 20),
                  Consumer<SignupViewModel>(
                    builder: (context, value, child) =>
                    Padding(
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
                            value.userFlowModel.name = _nameTextEditingController.text.toString();
                            value.userFlowModel.phone = _phoneTextEditingController.text.toString();
                            value.userFlowModel.idProof = _idProofTextEditingController.text.toString();
                            value.userFlowModel.address = _addressTextEditingController.text.toString();
                            Navigator.pushNamed(context, "signup2_view");
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
