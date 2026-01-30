import 'package:city_hub/data/response/status.dart';
import 'package:city_hub/data/services/token_storage.dart';
import 'package:city_hub/model/jwt_token_request_model.dart';
import 'package:city_hub/model_view/token_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final TokenStorage _tokenStorage;
  late final TokenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<TokenViewModel>();
    _tokenStorage = TokenStorage();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkToken();
    });
  }

  Future<void> _checkToken() async {
    final storedToken = await _tokenStorage.getToken();

    if (storedToken != null && storedToken.isNotEmpty) {
      JwtTokenRequest body = JwtTokenRequest(jwtToken: storedToken);

      try {
        await _viewModel.valitateToken(body);

        if (!mounted) return;

        // Use the status after Provider updates
        final status = _viewModel.apiTokenResponse?.status;
        if (status == Status.COMPLETED) {
          Navigator.pushReplacementNamed(context, "landing_view");
        } else {
          Navigator.pushReplacementNamed(context, "login_view");
        }
      } catch (_) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, "login_view");
      }
    } else {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "login_view");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
