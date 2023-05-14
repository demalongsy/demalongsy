import 'dart:convert';

List<AllUsers> allUsersFromJson(String str) =>
    List<AllUsers>.from(json.decode(str).map((x) => AllUsers.fromJson(x)));

String allUsersToJson(List<AllUsers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllUsers {
  String? password;
  String? name;
  String? username;
  List<String>? tags;
  List<dynamic>? liked;
  String? id;
  String? images;

  AllUsers(
      {this.password,
      this.name,
      this.username,
      this.tags,
      this.liked,
      this.id,
      this.images});

  factory AllUsers.fromJson(Map<String, dynamic> json) => AllUsers(
      password: json["password"],
      name: json["name"],
      username: json["username"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      liked: json["liked"] == null
          ? []
          : List<dynamic>.from(json["liked"]!.map((x) => x)),
      id: json["id"],
      images: json["images"]);

  Map<String, dynamic> toJson() => {
        "password": password,
        "name": name,
        "username": username,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "liked": liked == null ? [] : List<dynamic>.from(liked!.map((x) => x)),
        "id": id,
        "images": images
      };
}
