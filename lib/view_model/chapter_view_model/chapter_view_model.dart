import 'package:flutter/material.dart';
import 'package:talent_insider_app/models/apis/chapter_api_controller/chapter_api_controller.dart';
import 'package:talent_insider_app/models/chapter_model/chapter_model.dart';

enum ChapterViewState { none, loading, error }

class ChapterViewModel extends ChangeNotifier {
  ChapterViewState _state = ChapterViewState.none;
  ChapterViewState get state => _state;

  List<ChapterModel> _chapters = [];
  List<ChapterModel> get chapters => _chapters;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void changeState(ChapterViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchChapters(List<String> chapterIds) async {
    changeState(ChapterViewState.loading);
    _errorMessage = null;
    _chapters = [];
    notifyListeners();

    try {
      for (final chapterId in chapterIds) {
        final result = await ChapterApiController().getChapter(chapterId);
        if (result.isNotEmpty) {
          _chapters.add(result.first);
        }
      }
      changeState(ChapterViewState.none);
    } catch (e) {
      _errorMessage = e.toString();
      changeState(ChapterViewState.error);
    }
  }
}
