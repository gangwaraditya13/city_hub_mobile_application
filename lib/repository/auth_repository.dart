
import 'package:city_hub/data/app_exceptions.dart';
import 'package:city_hub/data/network/base_api_services.dart';
import 'package:city_hub/data/network/network_api_services.dart';
import 'package:city_hub/model/city_search_model.dart';
import 'package:city_hub/model/login_request_model.dart';
import 'package:city_hub/model/token_model.dart';
import 'package:city_hub/data/network/app_urls.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {

  ///DI
  final BaseApiServices _apiServices = NetworkApiServices();

  ///login
  Future<TokenModel> login(LoginRequestModel data) async {
    try {
      final response = await _apiServices.getPostApiResponse(
        AppUrls.loginUrl,
        data.toJson(),
      );
      return TokenModel.fromJson(response);
    } on AppExceptions {
      rethrow;
    } catch (e) {
      throw Exception("Unexpected login error");
    }
  }

  ///signup
  Future<dynamic> signup(UserModel data)async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrls.signUpUrl, data.toJson());
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("auth Repo signup " + e.toString());
      }
    }
  }

  ///city search
  Future<CitySearchModel> citySearch(String nameHint)async{
    try{
      final response =
      await _apiServices.getGetApiResponse(AppUrls.searchCity(nameHint));
      return CitySearchModel.fromJson(response);
    }on AppExceptions {
      rethrow;
    }
    catch(e){
      if(kDebugMode){
        print("auth Repo city search" + e.toString());
      }
      throw Exception("auth Repo city search" + e.toString());
    }
  }


}