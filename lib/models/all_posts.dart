import 'dart:convert';

List<AllPosts> allPostsFromJson(String str) =>
    List<AllPosts>.from(json.decode(str).map((x) => AllPosts.fromJson(x)));

String allPostsToJson(List<AllPosts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPosts {
  String? date;
  List<String>? images;
  String? name;
  String? imgAuthor;
  String? authorId;
  String? title;
  String? username;
  String? desc;
  List<String>? tags;
  List<String>? liked;
  int? numComment;
  String? id;
  bool? isLiked;

  AllPosts({
    this.date,
    this.images,
    this.name,
    this.imgAuthor,
    this.authorId,
    this.title,
    this.username,
    this.desc,
    this.tags,
    this.liked,
    this.numComment,
    this.id,
    this.isLiked,
  });

  factory AllPosts.fromJson(Map<String, dynamic> json) => AllPosts(
        date: json["date"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        name: json["name"],
        imgAuthor: json["imgAuthor"],
        authorId: json["author_id"],
        title: json["title"],
        username: json["username"],
        desc: json["desc"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        liked: json["liked"] == null
            ? []
            : List<String>.from(json["liked"]!.map((x) => x)),
        numComment: json["num_comment"],
        id: json["id"],
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "name": name,
        "imgAuthor": imgAuthor,
        "author_id": authorId,
        "title": title,
        "username": username,
        "desc": desc,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "liked": liked == null ? [] : List<dynamic>.from(liked!.map((x) => x)),
        "num_comment": numComment,
        "id": id,
        "isLiked": isLiked,
      };
}
