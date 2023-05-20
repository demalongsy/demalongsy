import 'dart:convert';

ViewSimilar viewSimilarFromJson(String str) =>
    ViewSimilar.fromJson(json.decode(str));

String viewSimilarToJson(ViewSimilar data) => json.encode(data.toJson());

class ViewSimilar {
  String? image;
  String? link;
  String? description;
  String? productBrand;
  String? category;
  String? productName;

  ViewSimilar({
    this.image,
    this.link,
    this.description,
    this.productBrand,
    this.category,
    this.productName,
  });

  factory ViewSimilar.fromJson(Map<String, dynamic> json) => ViewSimilar(
        image: json["image"],
        link: json["link"],
        description: json["description"],
        productBrand: json["product_brand"],
        category: json["category"],
        productName: json["product_name"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "link": link,
        "description": description,
        "product_brand": productBrand,
        "category": category,
        "product_name": productName,
      };
}
