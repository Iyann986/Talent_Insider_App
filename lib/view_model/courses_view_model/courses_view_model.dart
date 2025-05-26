import 'package:flutter/material.dart';
import 'package:talent_insider_app/models/apis/course_api_controller/course_api_controller.dart';
import 'package:talent_insider_app/models/courses_model/courses_model.dart';

enum CourseViewState { none, loading, error }

class CourseViewModel extends ChangeNotifier {
  CourseViewState _state = CourseViewState.none;
  CourseViewState get state => _state;

  List<CourseModel> _courses = [];
  List<CourseModel> get courses => _courses;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final CourseApiController _apiController = CourseApiController();

  void changeState(CourseViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchCourses() async {
    changeState(CourseViewState.loading);
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedCourses = await _apiController.getCourses();
      print('Fetched courses count: ${fetchedCourses.length}');
      _courses = fetchedCourses;
      changeState(CourseViewState.none);
    } catch (e) {
      _errorMessage = e.toString();
      changeState(CourseViewState.error);
    }
  }
}
