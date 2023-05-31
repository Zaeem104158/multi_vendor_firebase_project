import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModelClass {
  String? imageFile;
  String? fullName;
  String? email;

  UserInfoModelClass({this.imageFile, this.fullName, this.email});

  UserInfoModelClass.fromJson(Map<String, dynamic> json) {
    imageFile = json['imageFile'];
    fullName = json['fullName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageFile'] = this.imageFile;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    return data;
  }

  factory UserInfoModelClass.fromMap(Map<String, dynamic> map) {
    return UserInfoModelClass(
      imageFile: map['imageFile'],
      fullName: map['fullName'],
      email: map['email'],
    );
  }

  UserInfoModelClass.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : imageFile = doc.data()!["imageFile"],
        fullName = doc.data()!["fullName"],
        email = doc.data()!["email"];
}
