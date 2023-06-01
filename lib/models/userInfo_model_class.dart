// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserInfoModelClass {
//   String? imageFile;
//   String? fullName;
//   String? email;
//   String? address;
//   String? phoneNumber;
//   String? cid;

//   UserInfoModelClass(
//       {this.phoneNumber,
//       this.address,
//       this.cid,
//       this.imageFile,
//       this.fullName,
//       this.email});

//   UserInfoModelClass.fromJson(Map<String, dynamic> json) {
//     imageFile = json['imageFile'];
//     fullName = json['fullName'];
//     email = json['email'];
//     cid = json['cid'];
//     address = json['address'];
//     phoneNumber = json['phoneNumber'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['imageFile'] = this.imageFile;
//     data['fullName'] = this.fullName;
//     data['email'] = this.email;
//     data['cid'] = this.cid;
//     data['address'] = this.address;
//     data['phoneNumber'] = this.phoneNumber;
//     return data;
//   }

//   factory UserInfoModelClass.fromMap(Map<String, dynamic> map) {
//     return UserInfoModelClass(
//       imageFile: map['imageFile'],
//       fullName: map['fullName'],
//       email: map['email'],
//       cid: map['cid'],
//       address: map['address'],
//       phoneNumber: map['phoneNumber'],
//     );
//   }

//   // UserInfoModelClass.fromDocumentSnapshot(
//   //     DocumentSnapshot<Map<String, dynamic>> doc)
//   //     : imageFile = doc.data()!["imageFile"],
//   //       fullName = doc.data()!["fullName"],
//   //       email = doc.data()!["email"];
// }

class UserInfoModelClass {
  String? imageFile;
  String? fullName;
  String? email;
  String? cid;
  String? address;
  String? phoneNumber;

  UserInfoModelClass(
      {this.imageFile,
      this.fullName,
      this.email,
      this.cid,
      this.address,
      this.phoneNumber});

  UserInfoModelClass.fromJson(Map<String, dynamic> json) {
    imageFile = json['imageFile'];
    fullName = json['fullName'];
    email = json['email'];
    cid = json['cid'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageFile'] = this.imageFile;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['cid'] = this.cid;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }

  factory UserInfoModelClass.fromMap(Map<String, dynamic> map) {
    return UserInfoModelClass(
      imageFile: map['imageFile'],
      fullName: map['fullName'],
      email: map['email'],
      cid: map['cid'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
