import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:video_app/models/video.dart';

class ApiService {
  static const String apiUrl = 'http://192.168.1.118:8000/api/videos';

  Future<List<Video>> fetchVideos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((video) => Video.fromJson(video)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  Future<bool> uploadVideo(File videoFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/upload'),
    );
    request.files
        .add(await http.MultipartFile.fromPath('video', videoFile.path));
    var response = await request.send();

    return response.statusCode == 200;
  }
}
