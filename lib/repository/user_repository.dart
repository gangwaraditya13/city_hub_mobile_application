import 'package:city_hub/data/app_exceptions.dart';
import 'package:city_hub/data/network/app_urls.dart';
import 'package:city_hub/data/network/base_api_services.dart';
import 'package:city_hub/data/network/network_api_services.dart';
import 'package:city_hub/model/user_model.dart';

class UserRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();

  Future<UserModel> getUserDetail()async{
    try{
      final response = await _baseApiServices.getGetApiResponse(AppUrls.userInfoDetailsUrl,withAuth: true);
      return UserModel.fromJson(response);
    }on AppExceptions{
      rethrow;
    }catch(e){
      throw Exception("unable to Fetching User detail error in HomeRepository");
    }
  }
}