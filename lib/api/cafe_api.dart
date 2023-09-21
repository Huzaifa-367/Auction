import 'package:dio/dio.dart';
import 'package:flutter_admin_dashboard/api/ApiHandler.dart';

class CafeApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    //Base Url
  }

  // Peticiones Http
  // GET
  static Future httpGet(String path) async {
    try {
      final response = await Dio().get(path);
      return response.data;
    } catch (e) {
      print(e);
      throw ('Error en GET del HTTP');
    }
  }

  // POST
  static Future httpPost(String path, Map<String, dynamic> data) async {
    print(path);
    final formData = FormData.fromMap(data);
    try {
      final response = await Dio().post(path, data: formData, options: option);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
