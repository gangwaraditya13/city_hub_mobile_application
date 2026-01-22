import 'package:city_hub/data/response/api_response.dart';
import 'package:city_hub/data/services/token_storage.dart';
import 'package:city_hub/model/login_request_model.dart';
import 'package:city_hub/model/token_model.dart';
import 'package:city_hub/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class LoginViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final TokenStorage _tokenStorage = TokenStorage();

  ApiResponse<TokenModel>? loginResponse;

  Future<void> login(LoginRequestModel request) async {
    loginResponse = ApiResponse.loading();
    notifyListeners();

    try {
      final token = await _authRepository.login(request);
      loginResponse = ApiResponse.completed(token);
      await _tokenStorage.saveToken(token.jwtToken!);
      notifyListeners();
    } catch (e) {
      loginResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
