import 'package:cloud_firestore/cloud_firestore.dart';

class PictureData {
  final String pictureURL;
  final Timestamp pictureDate;

  PictureData({
    required this.pictureURL,
    required this.pictureDate
  });

  factory PictureData.fromMap(Map<String, dynamic> map) {
    return PictureData(
      pictureURL: map['picture'],
      pictureDate: map['date']
    );
  }
}