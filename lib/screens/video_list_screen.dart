import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_app/providers/video_provider.dart';
import 'package:video_app/screens/video_player_screen.dart';
import 'package:video_app/widgets/video_tile.dart';
import 'dart:io';

class VideoListScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: Consumer<VideoProvider>(builder: (context, videoProvider, child) {
        if (videoProvider.videos.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: videoProvider.videos.length,
              itemBuilder: (context, index) {
                final video = videoProvider.videos[index];
                return VideoTile(
                  video: video,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VideoPlayerScreen(url: video.url)));
                  },
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final XFile? video =
              await _picker.pickVideo(source: ImageSource.camera);

          if (video != null) {
            bool? confirm = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Confirmar"),
                    content: Text("¿Desea cargar el video?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Enviar'),
                      ),
                    ],
                  );
                });

            if (confirm == true) {
              File videoFile = File(video.path);
              bool success =
                  await Provider.of<VideoProvider>(context, listen: false)
                      .uploadVideo(videoFile);

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Video enviado exitosamente')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al enviar el video')),
                );
              }
            }
          }
          // Logica para agregar un nuveo video
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
