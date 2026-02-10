
class AppUrls {

  static String _baseUrl = "https://smartcityinformationportal.onrender.com/cityhub";

  ///token validate
  static String validateToken = "${_baseUrl}/public/validate-token";//

  ///user auth
  static String loginUrl = "${_baseUrl}/public/login";//
  static String signUpUrl = "${_baseUrl}/public/signup";//

  ///user
  static String userInfoDetailsUrl = "${_baseUrl}/user/getuser";//
  static String ownCityInfoUrl = "${_baseUrl}/user/own-city-info";//
  static String OtherCityInfoUrl = "${_baseUrl}/user/other-city-info";
  static String userDetailUpdateUrl = "${_baseUrl}/user/update-user";//
  static String userPasswordUpdateUrl = "${_baseUrl}/user/update-password";//
  static String userDeleteUrl = "${_baseUrl}/user/delete-user";//

  ///image upload
  static String uploadImage = "${_baseUrl}/user/image-upload";////
  ///set user pic to user
  static String setUserProfilepicInUser = "${_baseUrl}/user/update-profile-image";//
  ///image delete of User pic
  static String deleteUserProfilePic = "${_baseUrl}/user/delete-profile-image";

  ///complaint
  static String newComplaintUrl = "${_baseUrl}/complaint";//

  static String updateComplaintUrl = "${_baseUrl}/complaint/update-complaint";//

  static String deleteComplaint(String complaintId){
    return "${_baseUrl}/complaint/delete-complaint/${complaintId}";//
  }

  static String getOneComplaint(String complaintId){
    return "${_baseUrl}/complaint/get-complaint/${complaintId}";
  }

  static String searchCity(String cityHint){
    return "${_baseUrl}/public/city/${cityHint}";//
  }

  ///cityUpdates
  static String getCityUpdate = "${_baseUrl}/user/city-updates";//

}