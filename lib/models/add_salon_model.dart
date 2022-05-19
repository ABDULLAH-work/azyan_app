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
  String? uIdHair;
  String? uIdFace;
  String? uIdBody;
  String? description;
  String? location;
  String? stateWork;
  int? openOrClose;
  int? hoursStart;
  int? hoursEnd;
  double? ratting;

  AddSalonModel({
    this.uId,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.image,
    this.state,
    this.hair,
    this.face,
    this.body,
    this.description,
    this.ratting,
    this.location,
    this.openOrClose,
    this.stateWork,
    this.hoursEnd,
    this.hoursStart,
    this.uIdHair,
    this.uIdFace,
    this.uIdBody
  });

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
    description = json['description'];
    ratting = json['ratting'];
    location = json['location'];
    openOrClose = json['openOrClose'];
    hoursEnd = json['hoursEnd'];
    hoursStart = json['hoursStart'];
    stateWork = json['stateWork'];
    uIdHair = json['uIdHair'];
    uIdFace = json['uIdFace'];
    uIdBody = json['uIdBody'];

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
      'stateWork': stateWork,
      'description': description,
      'ratting': ratting,
      'location': location,
      'openOrClose': openOrClose,
      'hoursStart': hoursStart,
      'hoursEnd': hoursEnd,
      'uIdHair': uIdHair,
      'uIdFace': uIdFace,
      'uIdBody': uIdBody,
    };
  }
}
