class ChatUserModel {
  String? name;
  String? image;

  ChatUserModel({
    this.name,
    this.image,

  });

  ChatUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
 

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }
}
