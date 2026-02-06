import 'package:city_hub/data/app_exceptions.dart';
import 'package:city_hub/data/network/app_urls.dart';
import 'package:city_hub/data/network/base_api_services.dart';
import 'package:city_hub/data/network/network_api_services.dart';
import 'package:city_hub/model/city_info_model.dart';

class FacilityRepository {

  final BaseApiServices _baseApiServices = NetworkApiServices();

  Future<CityInfoModel> getOwnCityInfo()async{
    try{
      final response = await _baseApiServices.getGetApiResponse(AppUrls.ownCityInfoUrl,withAuth: true);
      return CityInfoModel.fromJson(response);
    }on AppExceptions{
      rethrow;
    }catch(e){
      throw Exception("unable to fetch your City Info");
    }
  }

}