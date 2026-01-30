import 'package:city_hub/data/services/token_storage.dart';
import 'package:flutter/cupertino.dart';

class UserProfileViewModel with ChangeNotifier{

  final TokenStorage _tokenStorage = TokenStorage();

  Future<bool> logout()async{
    return await _tokenStorage.clear();
  }

}