import 'package:city_hub/data/response/api_response.dart';
import 'package:city_hub/model/city_updates_model.dart';
import 'package:city_hub/model/user_model.dart';
import 'package:city_hub/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel with  ChangeNotifier {

  final HomeRepository _homeRepository = HomeRepository();

  ApiResponse<UserModel>? apiUserDetailResponse;
  ApiResponse<CityUpdates>? apiCityUpdatesResponse;

  Future<void> getUserDetail()async{
    apiUserDetailResponse = ApiResponse.loading();
    notifyListeners();
    try{
      UserModel userDetail = await _homeRepository.getUserDetail();
      apiUserDetailResponse = ApiResponse.completed(userDetail);
      notifyListeners();
    }catch(e){
      apiUserDetailResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> getCityUpdates()async{
    apiCityUpdatesResponse = ApiResponse.loading();
    notifyListeners();
    try{
      CityUpdates cityUpdates = await _homeRepository.getCityUpdates();
      if(kDebugMode){
        print(cityUpdates);
      }
      apiCityUpdatesResponse = ApiResponse.completed(cityUpdates);
      notifyListeners();
    }catch(e){
      apiCityUpdatesResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> reloadHome() async {
    await getUserDetail();
    await getCityUpdates();
  }

}