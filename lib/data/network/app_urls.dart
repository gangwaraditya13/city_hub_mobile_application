
class AppUrls {

  static String _baseUrl = "http://10.0.2.2:8080/cityhub";

  ///user auth
  static String loginUrl = "${_baseUrl}/public/login";
  static String signUpUrl = "${_baseUrl}/public/signup";

  ///user
  static String userInfoDetailsUrl = "${_baseUrl}/user/getuser";
  static String ownCityInfoUrl = "${_baseUrl}/user/own-city-info";
  static String OtherCityInfoUrl = "${_baseUrl}/user/other-city-info";
  static String userDetailUpdateUrl = "${_baseUrl}/user/update-user";
  static String userPasswordUpdateUrl = "${_baseUrl}/user/update-password";
  static String userDeleteUrl = "${_baseUrl}/user/delete-user";

  ///complaint
  static String newComplaintUrl = "${_baseUrl}/complaint";

  static String updateComplaintUrl = "${_baseUrl}/complaint/update-complaint";

  static String deleteComplaint(String complaintId){
    return "${_baseUrl}/complaint/delete-complaint/${complaintId}";
  }

  static String getOneComplaint(String complaintId){
    return "${_baseUrl}/complaint/get-complaint/${complaintId}";
  }

  static String searchCity(String cityHint){
    return "${_baseUrl}/public/city/${cityHint}";
  }

}