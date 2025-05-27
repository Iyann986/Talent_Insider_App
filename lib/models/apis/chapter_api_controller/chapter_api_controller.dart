import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_insider_app/models/chapter_model/chapter_model.dart';

class ChapterApiController {
  Future<List<ChapterModel>> getChapter(String chapterId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.https(
      'api.kontenbase.com',
      '/query/api/v1/2810aabc-9dc5-4d37-8ff1-fd579e9d6f0c/chapter/$chapterId',
      {r'$lookup': '*'},
    );

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return [ChapterModel.fromJson(data)];
    } else {
      throw Exception('Failed to load audio data: ${response.statusCode}');
    }
  }
}
