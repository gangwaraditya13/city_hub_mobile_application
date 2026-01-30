import 'package:city_hub/data/response/api_response.dart';
import 'package:city_hub/model/jwt_token_request_model.dart';
import 'package:city_hub/repository/token_repository.dart';
import 'package:flutter/cupertino.dart';

class TokenViewModel with ChangeNotifier{

  final TokenRepository _tokenRepository = TokenRepository();

  ApiResponse<void>? apiTokenResponse;

  Future<void> valitateToken(JwtTokenRequest jwtTokenRequest)async{
    apiTokenResponse = ApiResponse.loading();
    notifyListeners();
    try{
      await _tokenRepository.varifyAuthToken(jwtTokenRequest);
      apiTokenResponse = ApiResponse.completed(null);
      notifyListeners();
    }catch(e){
      apiTokenResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}