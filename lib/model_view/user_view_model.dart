import 'package:city_hub/data/response/api_response.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:city_hub/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewModel with ChangeNotifier{

  final UserRepository _userRepository = UserRepository();

  ApiResponse<UserModel>? apiUserModelResponse;

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
}