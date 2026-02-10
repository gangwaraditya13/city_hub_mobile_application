import 'package:city_hub/data/response/api_response.dart';
import 'package:city_hub/model/user_complaint_model.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:city_hub/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewModel with ChangeNotifier{

  final UserRepository _userRepository = UserRepository();

  ApiResponse<UserModel>? apiUserModelResponse;
  ApiResponse<void>? apiUpdateUserModelResponse;
  ApiResponse<void>? apiUserDeletePermanentResponse;
  ApiResponse<void>? apiUpdateUserComplaintResponse;
  ApiResponse<void>? apiDeleteUserComplaintResponse;
  ApiResponse<void>? apiUpdateUserModelProfilePicResponse;
  ApiResponse<void>? apiUpdateUserModelPasswordResponse;

  Future<void> getUserDetail()async{
    apiUserModelResponse = ApiResponse.loading();
    notifyListeners();
    try{
       UserModel userModel = await _userRepository.getUserDetail();
       apiUserModelResponse = ApiResponse.completed(userModel);
      notifyListeners();
    }catch(e){
      apiUserModelResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> updateUserDetails(UserModel userModel)async{
    apiUpdateUserModelResponse = ApiResponse.loading();
    notifyListeners();
    try{
      await _userRepository.updateUserDetail(userModel);
      apiUpdateUserModelResponse = ApiResponse.completed(null);
      notifyListeners();
    }catch(e){
      apiUpdateUserModelResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> deleteUserPermanently(UserModel userModel)async{
    apiUserDeletePermanentResponse = ApiResponse.loading();
    notifyListeners();
    try{
      await _userRepository.deleteUserPermanently(userModel);
      apiUserDeletePermanentResponse = ApiResponse.completed(null);
      notifyListeners();
    }catch(e){
      apiUserDeletePermanentResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> updateUserComplaint(UserComplaintModel userComplaintModel)async{
    apiUpdateUserComplaintResponse = ApiResponse.loading();
    notifyListeners();
    try{
      await _userRepository.updateUserComplaint(userComplaintModel);
      apiUpdateUserComplaintResponse = ApiResponse.completed(null);
      notifyListeners();
    }catch(e){
      apiUpdateUserComplaintResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> updateUserProfilePic(UserModel userModel)async{
    apiUpdateUserModelProfilePicResponse = ApiResponse.loading();
    notifyListeners();
    try{
      await _userRepository.updatingUserPic(userModel);
      apiUpdateUserModelProfilePicResponse = ApiResponse.completed(null);
      notifyListeners();
    }catch(e){
      apiUpdateUserModelProfilePicResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> updateUserPassword(UserModel userModel)async{
    apiUpdateUserModelPasswordResponse = ApiResponse.loading();
    notifyListeners();
    try{
      await _userRepository.updatePassword(userModel);
      apiUpdateUserModelPasswordResponse = ApiResponse.completed(null);
      notifyListeners();
    }catch(e){
      apiUpdateUserModelPasswordResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> deleteUserComplaint(String complaintId)async{
    apiDeleteUserComplaintResponse = ApiResponse.loading();
    notifyListeners();
    try{
      await _userRepository.deleteComplaint(complaintId);
      apiDeleteUserComplaintResponse = ApiResponse.completed(null);
      notifyListeners();
    }catch(e){
      apiDeleteUserComplaintResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> reloadUserDetail()async{
    await getUserDetail();
  }

}