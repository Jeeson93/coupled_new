import 'dart:convert';

OnlineChatList onlineUsersFromMap(String str) =>
    OnlineChatList.fromMap(json.decode(str));

String onlineUsersToMap(OnlineChatList data) => json.encode(data.toMap());

class OnlineChatList {
  OnlineChatList({
    this.data = const <Datum>[],
  });

  List<Datum> data;

  factory OnlineChatList.fromMap(Map<String, dynamic> json) => OnlineChatList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'OnlineChatList{data: $data}';
  }
}

class Datum {
  Datum({
    this.id = 0,
    this.name = '',
    this.fullName = '',
    this.memCode = '',
  });

  int id;
  String name;
  String fullName;
  String memCode;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        fullName: json["fullName"],
        memCode: json["memCode"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "fullName": fullName,
        "memCode": memCode,
      };

  @override
  String toString() {
    return 'Datum{id: $id, name: $name, fullName: $fullName, memCode: $memCode}';
  }
}
