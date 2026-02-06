abstract class BaseApiServices {

  Future<dynamic> getGetApiResponse(String url, {bool withAuth});
  Future<dynamic> getPostApiResponse(String url, dynamic body, {bool withAuth});
  Future<dynamic> getPutApiResponse(String url, dynamic body, {bool withAuth});
  Future<dynamic> getDeleteApiResponse(String url, {bool withAuth} );

}