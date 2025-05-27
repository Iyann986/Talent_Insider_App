import 'package:flutter/material.dart';
import 'package:talent_insider_app/models/apis/video_api_controller/video_api_controller.dart';
import 'package:talent_insider_app/models/video_model/video_model.dart';

enum VideoLessonViewState { none, loading, error }

class VideoLessonViewModel extends ChangeNotifier {
  VideoLessonViewState _state = VideoLessonViewState.none;
  VideoLessonViewState get state => _state;

  List<VideoLessonModel> _videoLessons = [];
  List<VideoLessonModel> get videoLessons => _videoLessons;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void changeState(VideoLessonViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchVideoLessons(List<String> videoLessonIds) async {
    changeState(VideoLessonViewState.loading);
    _errorMessage = null;
    _videoLessons = [];

    try {
      for (final lessonId in videoLessonIds) {
        print('Fetching video for lessonId: $lessonId');
        final result = await VideoApiController().getVideoLesson(lessonId);
        if (result.isNotEmpty) {
          _videoLessons.add(result.first);
        }
      }
      changeState(VideoLessonViewState.none);
    } catch (e) {
      _errorMessage = e.toString();
      changeState(VideoLessonViewState.error);
    }
  }
}
