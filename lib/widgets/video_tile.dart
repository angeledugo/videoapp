import 'package:flutter/material.dart';
import 'package:video_app/models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  VideoTile({required this.video, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(video.title),
      onTap: onTap,
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
    );
  }
}
