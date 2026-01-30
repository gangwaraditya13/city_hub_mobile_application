import 'package:city_hub/data/app_exceptions.dart';
import 'package:city_hub/data/network/app_urls.dart';
import 'package:city_hub/data/network/network_api_services.dart';
import 'package:city_hub/model/jwt_token_request_model.dart';

import '../data/network/base_api_services.dart';

class TokenRepository {

  final BaseApiServices _baseApiServices = NetworkApiServices();

  Future<dynamic> varifyAuthToken(JwtTokenRequest jwtTokenRequest)async{
    try{
      dynamic response = await _baseApiServices.getPostApiResponse(AppUrls.validateToken, jwtTokenRequest.toJson());
      return response;
    }on AppExceptions{
      rethrow;
    }
    catch(e){
      throw Exception("Unexpected token error");
    }
  }
}