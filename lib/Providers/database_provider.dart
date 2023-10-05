import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Create an instance of Firebase Firestore.

  Stream get allPictures => _firestore.collection("pictures").snapshots(); // a stream that is continuously listening for changes happening in the database
  late CollectionReference _pictures;  
  // Add a Picture
  // A method that will add a new Picture from imageFile to our Pictures collection and return true if its successful.
  Future<bool> addNewPicture(String imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageReference = FirebaseStorage.instance.ref().child('pictures/$fileName');
      final file = File(imageFile);

      final uploadTask = await storageReference.putFile(file);

      await uploadTask.ref.getDownloadURL().then((value) async => {

        _pictures = _firestore.collection('pictures'),

        await _pictures.doc(fileName).set(
          {'picture': value, 'date': DateTime.now(), 'id': fileName}), // Adding a new document
        });

      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
 
}

// Creating a simple Riverpod provider that provides an instance of our Database class so that it can be used from our UI(by calling Database class methods)
final databaseProvider = Provider((ref) => Database());