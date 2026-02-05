import 'package:city_hub/data/app_exceptions.dart';
import 'package:city_hub/data/network/app_urls.dart';
import 'package:city_hub/data/network/base_api_services.dart';
import 'package:city_hub/data/network/network_api_services.dart';
import 'package:city_hub/model/user_complaint_model.dart';
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

  Future<dynamic> updateUserDetail(UserModel userModel)async{
    try{
      final response = await _baseApiServices.getPutApiResponse(AppUrls.userDetailUpdateUrl, userModel.toJsonUpdateNameOrGmail(), withAuth: true);
      return response;
    }on AppExceptions{
      rethrow;
    }catch(e){
      throw Exception("unable to update User Detail");
    }
  }

  Future<dynamic> updatePassword(UserModel userModel)async{
    try{
      final response = await _baseApiServices.getPutApiResponse(AppUrls.userPasswordUpdateUrl, userModel.toJsonUpdatePassword(),withAuth: true);
      return response;
    }on AppExceptions{
      rethrow;
    }catch(e){
      throw Exception("unable to change password");
    }
  }
  
  Future<dynamic> updateUserComplaint(UserComplaintModel complaintModel)async{
    try{
      final response = await _baseApiServices.getPutApiResponse(AppUrls.updateComplaintUrl, complaintModel.toJsonUpdate());
      return response;
    }on AppExceptions{
      rethrow;
    }catch(e){
      throw Exception("unable to update complaint");
    }
  }

  Future<dynamic> updatingUserPic(UserModel userModel)async{
    try{
      final response = await _baseApiServices.getPutApiResponse(AppUrls.setUserProfilepicInUser, userModel.toJsonUpdateProfilePic(), withAuth: true);
      return response;
    }on AppExceptions{
      rethrow;
    }catch(e){
      throw Exception("unable to update profile pic");
    }
  }

}