import 'dart:convert';
import 'dart:io';

import 'package:city_hub/data/app_exceptions.dart';
import 'package:city_hub/data/network/app_urls.dart';
import 'package:city_hub/data/services/token_storage.dart';
import 'package:city_hub/model/cloudinary_image_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class ImageRepository {

  final TokenStorage _tokenStorage = TokenStorage();

  Future<CloudinaryImage?> uploadImage(File file) async {

    final targetPath = path.join(
      Directory.systemTemp.path,
      'temp_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 70,
    );

    if (compressedFile == null) return null;

    final token = await _tokenStorage.getToken();
    if (token == null) {
      throw Exception("JWT token not found");
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(AppUrls.uploadImage),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    request.files.add(
      await http.MultipartFile.fromPath('image', compressedFile.path),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    switch (response.statusCode) {
      case 200:
      case 201:
        return CloudinaryImage.fromJson(jsonDecode(responseBody));
      case 400:
        throw BadRequestExecption("Bad request");

      case 401:
        throw UnauthorizedException("Token invalid or expired");

      case 403:
        throw UnauthorizedException("Forbidden");

      case 500:
        throw FatchDataExecption("Internal server error");

      default:
        throw FatchDataExecption(
          "Unexpected error: ${response.statusCode}",
        );
    }

    return null;
  }
}
