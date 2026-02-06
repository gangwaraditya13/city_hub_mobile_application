import 'package:city_hub/data/app_exceptions.dart';
import 'package:city_hub/data/network/app_urls.dart';
import 'package:city_hub/data/network/base_api_services.dart';
import 'package:city_hub/data/network/network_api_services.dart';
import 'package:city_hub/model/city_updates_model.dart';
import 'package:city_hub/model/user_complaint_model.dart';
import 'package:city_hub/model/user_model.dart';

class HomeRepository{

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

  Future<CityUpdates> getCityUpdates()async{
    try{
      final response = await _baseApiServices.getGetApiResponse(AppUrls.getCityUpdate,withAuth: true);
      return CityUpdates.fromJson(response);
    }on AppExceptions{
      rethrow;
    }catch(e){
      throw Exception("unable to Fetching CityUpdates error in HomeRepository");
    }
  }

  Future<dynamic> postNewComplaint(UserComplaintModel complaintModel)async{
    try{
      final response = await _baseApiServices.getPostApiResponse(AppUrls.newComplaintUrl, complaintModel.toJson(),withAuth: true);
      return response;
    }on AppExceptions{
      rethrow;
    }catch(e){
      throw Exception("unable to post new Complaint");
    }
  }

}