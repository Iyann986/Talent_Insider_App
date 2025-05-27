import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_insider_app/models/video_model/video_model.dart';

class VideoApiController {
  Future<List<VideoLessonModel>> getVideoLesson(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.https(
      'api.kontenbase.com',
      '/query/api/v1/2810aabc-9dc5-4d37-8ff1-fd579e9d6f0c/lesson/$lessonId',
      {r'$lookup': '*'},
    );

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body lesson: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return [VideoLessonModel.fromJson(data)];
    } else {
      throw Exception('Failed to load audio data: ${response.statusCode}');
    }
  }
}
