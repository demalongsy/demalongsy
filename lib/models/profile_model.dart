// To parse this JSON data, do
//
//     final profileApi = profileApiFromJson(jsonString);

import 'dart:convert';

ProfileApi profileApiFromJson(String str) =>
    ProfileApi.fromJson(json.decode(str));

String profileApiToJson(ProfileApi data) => json.encode(data.toJson());

class ProfileApi {
  String? password;
  String? name;
  String? bio;
  String? img;
  String? username;
  List<String>? tags;
  List<String>? liked;
  String? userId;
  bool? isOwner;
  int? numPostes;
  int? numWasLiked;

  ProfileApi({
    this.password,
    this.name,
    this.bio,
    this.img,
    this.username,
    this.tags,
    this.liked,
    this.userId,
    this.isOwner,
    this.numPostes,
    this.numWasLiked,
  });

  factory ProfileApi.fromJson(Map<String, dynamic> json) => ProfileApi(
        password: json["password"],
        name: json["name"],
        bio: json["bio"],
        img: json["img"],
        username: json["username"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        liked: json["liked"] == null
            ? []
            : List<String>.from(json["liked"]!.map((x) => x)),
        userId: json["user_id"],
        isOwner: json["isOwner"],
        numPostes: json["num_postes"],
        numWasLiked: json["num_was_liked"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "name": name,
        "bio": bio,
        "img": img,
        "username": username,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "liked": liked == null ? [] : List<dynamic>.from(liked!.map((x) => x)),
        "user_id": userId,
        "isOwner": isOwner,
        "num_postes": numPostes,
        "num_was_liked": numWasLiked,
      };
}
