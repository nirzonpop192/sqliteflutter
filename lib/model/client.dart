import 'dart:convert';

// decode
Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

// encode
String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String firstName;
  String lastName;


  Client({this.id,
    this.firstName,
    this.lastName,});


  // desirialization named costructor
  factory Client.fromMap(Map<String, dynamic> json) => new Client(
    id:json["id"],
    firstName:json["first_name"],
    lastName: json["last_name"]);

  // serilization named constructor
  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,

  };
}
