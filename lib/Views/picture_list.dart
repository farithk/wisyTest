import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_camera/Models/picture.dart';
import 'package:wisy_camera/Providers/database_provider.dart';
import 'package:wisy_camera/Views/take_picture.dart';

class PictureList extends ConsumerWidget {
  const PictureList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.read(databaseProvider);  // Simply reading the Database Class instance provided by database Provider 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Photo Demo'),
      ),
      body: Center(
          child: StreamBuilder(   // Lets just use a stream builder that will listen to our Database class stream (a list of all documents/pictures)
            stream: database.allPictures, // the stream that provides all our data from the firestore database with real time changes
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator()); // Show a CircularProgressIndicator when the stream is loading
              }
              if (snapshot.error != null) {
                return const Center(child: Text('Some error occurred')); // Show an error just in case(no internet etc)
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0, 
                  mainAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  
                  final Map<String, dynamic> data = snapshot.data.docs[index].data();
                  final PictureData currentPicture = PictureData.fromMap(data);

                  return Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        color: const Color.fromARGB(255, 204, 204, 204),
                        child: FutureBuilder(
                          future: loadImage(currentPicture.pictureURL),
                          builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 180, 180, 180),
                                ), // Show a CircularProgressIndicator while loading
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error loading image'), // Handle error
                              );
                            } else {
                              return snapshot.data!; // Show the loaded image
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              );// Finally return a widget that shows a grid of pictures (snapshot.data.docs is the list of all documents )
            },
      )),
      floatingActionButton: FloatingActionButton( // A button that navigates to a camera view
        child: const Icon(Icons.camera_alt_outlined),
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CameraAwesomeApp()),
        );
        },
      ),
    );
  }
}

  Future<Image> loadImage(String imageUrl) async {
    final Completer<Image> completer = Completer<Image>();
    final Image image = Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          completer.complete(image);
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          completer.completeError(exception);
        },
      ),
    );

    return completer.future;
  }
