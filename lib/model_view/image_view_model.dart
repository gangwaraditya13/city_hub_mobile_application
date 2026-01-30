import 'dart:io';

import 'package:city_hub/data/response/api_response.dart';
import 'package:city_hub/model/cloudinary_image_model.dart';
import 'package:city_hub/repository/image_repository.dart';
import 'package:flutter/cupertino.dart';

class ImageViewModel with ChangeNotifier{

  final ImageRepository _imageRepository = ImageRepository();

  ApiResponse<CloudinaryImage>? apiCloudinaryImageResponse;

  Future<void> uploadImage(File file) async {
    apiCloudinaryImageResponse = ApiResponse.loading();
    notifyListeners();
    try {
      final _image = await _imageRepository.uploadImage(file);
      apiCloudinaryImageResponse = ApiResponse.completed(_image);
      notifyListeners();
    }catch (e) {
      apiCloudinaryImageResponse = ApiResponse.error(e.toString());
    notifyListeners();
    }
  }
}