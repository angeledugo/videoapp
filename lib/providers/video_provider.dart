import 'package:flutter/material.dart';
import 'package:video_app/models/video.dart';
import 'package:video_app/services/api_service.dart';
import 'dart:io';

class VideoProvider with ChangeNotifier {
  List<Video> _videos = [];
  final ApiService _apiService = ApiService();

  // Getter para acceder a la lista de videos desde fuera de la clase
  List<Video> get videos => _videos;

  // Metodo para obtener los videos de la api

  Future<void> fetchVideos() async {
    _videos = await _apiService.fetchVideos();
    notifyListeners();
  }

  // Metodo para enviar el video a la api
  Future<bool> uploadVideo(File videoFile) async {
    return await _apiService.uploadVideo(videoFile);
  }
}
