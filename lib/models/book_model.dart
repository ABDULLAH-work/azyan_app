class BookModel {
  String? uIdUser;
  String? uIdSalon;
  String? dateBook;
  String? timeBook;
  String? uIdBook;
  String? uIdServices;

  BookModel({
    this.uIdUser,
    this.uIdSalon,
    this.uIdBook,
    this.dateBook,
    this.timeBook,
    this.uIdServices,
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    uIdUser = json['uIdUser'];
    uIdSalon = json['uIdSalon'];
    dateBook = json['dateBook'];
    timeBook = json['timeBook'];
    uIdBook = json['uIdBook'];
    uIdServices = json['uIdServices'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uIdUser': uIdUser,
      'uIdSalon': uIdSalon,
      'dateBook': dateBook,
      'timeBook': timeBook,
      'uIdBook': uIdBook,
      'uIdServices': uIdServices,
    };
  }
}
