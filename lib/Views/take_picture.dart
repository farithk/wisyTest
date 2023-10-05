import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:wisy_camera/Providers/database_provider.dart';


class CameraAwesomeApp extends ConsumerWidget {
  const CameraAwesomeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    bool loading = false;

    final database = ref.read(databaseProvider); 
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photoAndVideo(
            photoPathBuilder: () => path(CaptureMode.photo),
            videoPathBuilder: () => path(CaptureMode.video),
            initialCaptureMode: CaptureMode.photo,
          ),
          enablePhysicalButton: true,
          filter: AwesomeFilter.AddictiveRed,
          flashMode: FlashMode.auto,
          aspectRatio: CameraAspectRatios.ratio_16_9,
          previewFit: CameraPreviewFit.fitWidth,
          onMediaTap: (mediaCapture) async {
            OpenFile.open(mediaCapture.filePath).whenComplete(() => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return AlertDialog(
                            title: const Center(
                              child: Text("Guardar foto"),
                            ),
                            content: const Text(
                              "Quieres guardar la foto?",
                              style: TextStyle(
                                fontSize: 16, // Adjust the font size as needed
                                fontWeight: FontWeight.w300, // Apply desired font weight
                                color: Colors.black, // Apply desired text color
                              ),
                            ),
                            actions: [
                              loading == true ? Container() : TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.grey, // Text color
                                ),
                                child: const Text("Cancelar"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                      loading = true;
                                    },);
                                  await database.addNewPicture(mediaCapture.filePath).then((value) => {
                                    setState(() {
                                      loading = false;
                                    },),
                                    Navigator.of(context).pop()
                                  }).catchError((e) {
                                    Navigator.of(context).pop();
                                    throw 'error $e';
                                  });
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.grey, // Text color
                                ),
                                child: loading == true ? const CircularProgressIndicator() : const Text("Guardar"),
                              ),
                            ]
                          );
                        }
                      );
                    }
                  )
            });
          },
        ),
      ),
    );
  }
}

Future<String> path(CaptureMode captureMode) async {
  final Directory extDir = await getTemporaryDirectory();
  final testDir =
      await Directory('${extDir.path}/test').create(recursive: true);
  final String fileExtension = captureMode == CaptureMode.photo ? 'jpg' : 'mp4';
  final String filePath =
      '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
  return filePath;
}