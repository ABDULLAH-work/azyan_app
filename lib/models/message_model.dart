class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? name;
  String? image;


  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.image,
    this.name

  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    name = json['name'];
    image = json['image'];

  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'name': name,
      'image': image,
    };
  }
}
