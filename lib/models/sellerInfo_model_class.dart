class SellerInfoModelClass {
  String? imageFile;
  String? fullName;
  String? email;
  String? sid;
  String? address;
  String? phoneNumber;

  SellerInfoModelClass(
      {this.imageFile,
      this.fullName,
      this.email,
      this.sid,
      this.address,
      this.phoneNumber});

  SellerInfoModelClass.fromJson(Map<String, dynamic> json) {
    imageFile = json['imageFile'];
    fullName = json['fullName'];
    email = json['email'];
    sid = json['sid'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageFile'] = this.imageFile;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['sid'] = this.sid;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }

  factory SellerInfoModelClass.fromMap(Map<String, dynamic> map) {
    return SellerInfoModelClass(
      imageFile: map['imageFile'],
      fullName: map['fullName'],
      email: map['email'],
      sid: map['sid'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
