import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_insider_app/models/user_model/user_model.dart';

class LoginApiController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<UserModel?> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    final url = Uri.parse(
      'https://api.kontenbase.com/query/api/v1/2810aabc-9dc5-4d37-8ff1-fd579e9d6f0c/auth/login',
    );

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final userModel = UserModel.fromJson(jsonData);

      // Simpan token & data user
      await saveToken(userModel.token);
      await saveUserInfo(userModel.user);

      return userModel;
    } else {
      // Handle error seperti menampilkan snackbar jika diperlukan
      debugPrint('Login failed: ${response.body}');
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> saveUserInfo(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', user.firstName);
    await prefs.setString('lastName', user.lastName);
    await prefs.setString('email', user.email);
    await prefs.setString('phoneNumber', user.phoneNumber);
    await prefs.setString('userId', user.id);
    await prefs.setStringList('roles', user.role);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
