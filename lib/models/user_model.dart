class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? location;
  String? status;
  String? image;
  String? state;

  UserModel({this.uId, this.name, this.email, this.phone,this.location,this.status,this.image,this.state});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    location = json['location'];
    status = json['status'];
    image = json['image'];
    state = json['state'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'location': location,
      'status': status,
      'image': image,
      'state': state,
    };
  }
}
