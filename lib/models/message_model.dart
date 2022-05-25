class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? name;
  String? image;
  String? imageSender;
  String? nameSender;
  String? roomId;
  String? receiverToken;
  String? senderToken;


  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.image,
    this.name,
    this.nameSender,
    this.imageSender,
    this.roomId,
    this.receiverToken,
    this.senderToken

  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    name = json['name'];
    image = json['image'];
    nameSender = json['nameSender'];
    imageSender = json['imageSender'];
    roomId = json['roomId'];
    receiverToken = json['receiverToken'];
    senderToken = json['senderToken'];


  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'name': name,
      'image': image,
      'nameSender': nameSender,
      'imageSender': imageSender,
      'roomId': roomId,
      'receiverToken': receiverToken,
      'senderToken': senderToken,

    };
  }
}
