import 'package:flutter/material.dart';
import 'package:video_app/models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  final VoidCallback onTap;

  VideoTile({required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(video.title),
      onTap: onTap,
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => {
          //TODO: Implementar lógica para eliminar video
        },
      ),
    );
  }
}
