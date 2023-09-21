import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/api/ApiHandler.dart';
import 'package:flutter_admin_dashboard/api/cafe_api.dart';
import 'package:flutter_admin_dashboard/services/local_storage.dart';
import 'package:flutter_admin_dashboard/services/notifications_service.dart';
import 'package:get/get.dart';
import '../models/User_Model.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  USER? user;

  AuthProvider() {
    isAuthenticated();
  }

  // LOGIN
  login(String email, String password) async {
    final data = {'email': email, 'password': password};

    // Peticion http POST LOGIN
    await CafeApi.httpPost(userLoginAPi, data).then((json) async {
      //print(json);
      try {
        // NotificationsService.showSnackBarError(json);
        var data = jsonDecode(json);
        if (data['success']) {
          //print(data['user']);
          final authResponse = USER.fromMap(data['user']);
          //print(authResponse);
          loggedinuser = authResponse;
          // navegar al dashboard
          authStatus = AuthStatus.authenticated;

          //LocalStorage.prefs.getString('token');

          //CafeApi.configureDio();
          notifyListeners();
          await LocalStorage.prefs
              .setString('loggedInUser', authResponse.toJson());
          //Get.to(const DashboardView());
        } else if (!data['success']) {
          NotificationsService.showSnackBarError(data['message']);
        }
      } catch (e) {
        NotificationsService.showSnackBarError(json);
      }
    }).catchError((e) {
      print('Error en: $e');
      //NotificationsService.showSnackBarError(e.toString());
    });
  }

  // REGISTER
  register({required USER user}) {
    //final data = {'nombre': fullName, 'correo': email, 'password': password};
    // Peticion http POST REGISTER
    CafeApi.httpPost(signUpAPi, user.toMap()).then((json) {
      print(json);
      //final authResponse = AuthResponse.fromMap(json);
      var data = jsonDecode(json);
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 2),
        message: data['message'],
      ));
    }).catchError((e) {
      print('Error en: $e');
      NotificationsService.showSnackBarError('User or Password not valid');
    });
  }

  // Funcion para para validar autenticacion
  Future<bool> isAuthenticated() async {
    // NO esta autenticado
    final token = LocalStorage.prefs.getString('loggedInUser');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    // SI esta autenticado
    try {
      // hacemos el get de la respuesta
      // final response = await CafeApi.httpGet('/auth');
      // final authRespponse = AuthResponse.fromMap(response);
      // LocalStorage.prefs.setString('token', authRespponse.token);
      // user = authRespponse.usuario;
      loggedinuser = USER.fromMap(jsonDecode(token));
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    // Se usaba antes para simular autenticacion
    /*
    await Future.delayed(const Duration(seconds: 1));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
    */
  }

  // LOGOUT
  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
