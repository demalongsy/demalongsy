import 'dart:convert';

ViewPostDetail viewPostDetailFromJson(String str) =>
    ViewPostDetail.fromJson(json.decode(str));

String viewPostDetailToJson(ViewPostDetail data) => json.encode(data.toJson());

class ViewPostDetail {
  String? date;
  String? name;
  int? numComment;
  String? imgAuthor;
  String? authorId;
  String? title;
  String? username;
  String? desc;
  List<String>? tags;
  List<String>? images;
  List<String>? liked;
  bool? isOwner;
  bool? isLiked;
  String? blockId;

  ViewPostDetail({
    this.date,
    this.name,
    this.numComment,
    this.imgAuthor,
    this.authorId,
    this.title,
    this.username,
    this.desc,
    this.tags,
    this.images,
    this.liked,
    this.isOwner,
    this.isLiked,
    this.blockId,
  });

  factory ViewPostDetail.fromJson(Map<String, dynamic> json) => ViewPostDetail(
        date: json["date"],
        name: json["name"],
        numComment: json["num_comment"],
        imgAuthor: json["imgAuthor"],
        authorId: json["author_id"],
        title: json["title"],
        username: json["username"],
        desc: json["desc"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        liked: json["liked"] == null
            ? []
            : List<String>.from(json["liked"]!.map((x) => x)),
        isOwner: json["isOwner"],
        isLiked: json["isLiked"],
        blockId: json["block_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "name": name,
        "num_comment": numComment,
        "imgAuthor": imgAuthor,
        "author_id": authorId,
        "title": title,
        "username": username,
        "desc": desc,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "liked": liked == null ? [] : List<dynamic>.from(liked!.map((x) => x)),
        "isOwner": isOwner,
        "isLiked": isLiked,
        "block_id": blockId,
      };
}
