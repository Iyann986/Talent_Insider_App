import 'package:flutter/material.dart';
import 'package:talent_insider_app/models/apis/audio_api_controller/audio_api_controller.dart';
import 'package:talent_insider_app/models/audio_model/audio_model.dart';

enum AudioBookViewState { none, loading, error }

class AudioBookViewModel extends ChangeNotifier {
  AudioBookViewState _state = AudioBookViewState.none;
  AudioBookViewState get state => _state;

  List<AudioModel> _audioBooks = [];
  List<AudioModel> get audioBooks => _audioBooks;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  final AudioApiController _apiController = AudioApiController();

  void changeState(AudioBookViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchAudioBooks() async {
    changeState(AudioBookViewState.loading);
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedAudioBooks = await _apiController.getAudio();
      print('Fetched audio books count: ${fetchedAudioBooks.length}');
      _audioBooks = fetchedAudioBooks;
      changeState(AudioBookViewState.none);
    } catch (e) {
      _errorMessage = e.toString();
      changeState(AudioBookViewState.error);
    }
  }
}
