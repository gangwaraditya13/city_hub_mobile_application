import 'package:city_hub/data/response/api_response.dart';
import 'package:city_hub/model/city_info_model.dart';
import 'package:city_hub/repository/facility_repository.dart';
import 'package:flutter/foundation.dart';

class FacilityViewModel with ChangeNotifier{

  final FacilityRepository _facilityRepository = FacilityRepository();

  ApiResponse<CityInfoModel>? apiOwnCityInfoResponse;

  Future<void> getOwnCityInfo()async{
    apiOwnCityInfoResponse = ApiResponse.loading();
    notifyListeners();
    try{
      final response =  await _facilityRepository.getOwnCityInfo();
      apiOwnCityInfoResponse = ApiResponse.completed(response);
      notifyListeners();
    }catch(e){
      apiOwnCityInfoResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

}