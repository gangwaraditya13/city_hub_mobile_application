class CitySearchModel {
  List<String>? cityName;

  CitySearchModel({this.cityName});

  CitySearchModel.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'].cast<String>();
  }
}
