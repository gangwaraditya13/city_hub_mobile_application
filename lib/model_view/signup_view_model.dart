import 'package:city_hub/data/response/api_response.dart';
import 'package:city_hub/model/city_search_model.dart';
import 'package:city_hub/model/user_flow_model.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../repository/auth_repository.dart';

class SignupViewModel with ChangeNotifier{
  final AuthRepository _authRepository = AuthRepository();

  ApiResponse<void>? signupResponse;

  ApiResponse<List<String>>? citySearchResponse;

  List<String> _suggestions = [];

  UserFlowModel _userFlowModel = UserFlowModel();


  UserFlowModel get userFlowModel => _userFlowModel;

  String printUserModelPass(){
    return userFlowModel.toString();
  }

  List<String> get suggestions => _suggestions;

  set suggestions(List<String> value) {
    _suggestions = value;
  }

  void clearSuggestions() {
    _suggestions.clear();
    notifyListeners();
  }

  ///signup
  Future<void> signUp(UserModel body)async{
    signupResponse = ApiResponse.loading();
    notifyListeners();
    try {
      await _authRepository.signup(body);
      signupResponse = ApiResponse.completed(null);
      notifyListeners();
    }catch(e){
      signupResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  ///search city
  Future<void> searchCity(String cityNameHint)async{
    citySearchResponse = ApiResponse.loading();
    notifyListeners();
    try{
      CitySearchModel citySearch = await _authRepository.citySearch(cityNameHint);
      suggestions = citySearch.cityName ?? [];
      citySearchResponse = ApiResponse.completed(suggestions);
      notifyListeners();
    }catch(e){
      citySearchResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

}