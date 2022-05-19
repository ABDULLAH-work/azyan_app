class ModelSalonServicesHair {
  bool? services1;
  bool? services2;
  bool? services3;
  bool? services4;
  bool? services5;
  bool? services6;
  bool? services7;
  bool? services8;

  ModelSalonServicesHair({
    this.services1,
    this.services2,
    this.services3,
    this.services4,
    this.services5,
    this.services6,
    this.services7,
    this.services8,
  });

  ModelSalonServicesHair.fromJson(Map<String, dynamic> json) {
    services1 = json['services 1'];
    services2 = json['services 2'];
    services3 = json['services 3'];
    services4 = json['services 4'];
    services5 = json['services 5'];
    services6 = json['services 6'];
    services7 = json['services 7'];
    services8 = json['services 8'];
  }
}
class ModelSalonServicesFace {
  bool? services1;
  bool? services2;
  bool? services3;
  bool? services4;
  bool? services5;
  bool? services6;


  ModelSalonServicesFace({
    this.services1,
    this.services2,
    this.services3,
    this.services4,
    this.services5,
    this.services6,
  });

  ModelSalonServicesFace.fromJson(Map<String, dynamic> json) {
    services1 = json['services 1'];
    services2 = json['services 2'];
    services3 = json['services 3'];
    services4 = json['services 4'];
    services5 = json['services 5'];
    services6 = json['services 6'];

  }
}
class ModelSalonServicesBody {
  bool? services1;
  bool? services2;
  bool? services3;
  bool? services4;
  bool? services5;


  ModelSalonServicesBody({
    this.services1,
    this.services2,
    this.services3,
    this.services4,
    this.services5,

  });

  ModelSalonServicesBody.fromJson(Map<String, dynamic> json) {
    services1 = json['services 1'];
    services2 = json['services 2'];
    services3 = json['services 3'];
    services4 = json['services 4'];
    services5 = json['services 5'];

  }
}
