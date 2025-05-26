import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_insider_app/models/courses_model/courses_model.dart';

class CourseApiController {
  Future<List<CourseModel>> getCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.https(
      'api.kontenbase.com',
      '/query/api/v1/2810aabc-9dc5-4d37-8ff1-fd579e9d6f0c/courses',
      {r'$lookup': '*'},
    );

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final courses = jsonList
          .map((json) => CourseModel.fromJson(json))
          .toList();
      return courses;
    } else {
      throw Exception(
        'Failed to load courses, status code: ${response.statusCode}',
      );
    }
  }
}
