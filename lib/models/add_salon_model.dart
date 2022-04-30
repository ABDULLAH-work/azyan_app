class AddSalonModel {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uId;
  String? image;
  String? state;
  String? hair;
  String? face;
  String? body;

  AddSalonModel(
      {this.uId,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.image,
      this.state,
      this.hair,
      this.face,
      this.body});

  AddSalonModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    hair = json['hair'];
    face = json['face'];
    body = json['body'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'uId': uId,
      'image': image,
      'state': state,
      'face': face,
      'body': body,
      'hair': hair,
    };
  }
}
