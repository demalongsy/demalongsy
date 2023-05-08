import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/post/view_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class ShowPost extends StatefulWidget {
  final String topic;
  final String name;
  final String imgAcc;
  final String imgPath;
  final bool isLiked;
  final String block_id;
  final String author_id;
  final String author_username;
  final String imgAuthor;
  final List<dynamic> tags;
  const ShowPost(
      {Key? key,
      required this.topic,
      required this.name,
      required this.imgAcc,
      required this.imgPath,
      required this.isLiked,
      required this.block_id,
      required this.author_id,
      required this.author_username,
      required this.imgAuthor,
      required this.tags})
      : super(key: key);

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  bool isFavorited = false;
  @override
  void initState() {
    setState(() {
      isFavorited = widget.isLiked;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context, rootNavigator: false).push(createTransitionRoute(
            ViewPost(
              tags: widget.tags,
              block_id: widget.block_id,
              author_username: widget.author_username,
              imgAuthor: widget.imgAuthor,
            ),
            1,
            0));
      }),
      child: Container(
        height: 289,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, 3),
          ),
        ], color: C.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 198,
                //width: 168,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  image: DecorationImage(
                      image: NetworkImage(widget.imgPath), fit: BoxFit.fill),
                ),
              ),
              Container(
                height: 57,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Poppins(
                    text: widget.topic,
                    size: 14,
                    color: C.dark1,
                    fontWeight: FW.bold,
                    letterspacing: 0.64,
                    maxLines: 2,
                    fontRespon: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Color(0xff74EDED),
                      backgroundImage: NetworkImage(widget.imgAcc),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Poppins(
                      text: widget.name,
                      size: 10,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      letterspacing: 0.64,
                      maxLines: 1,
                      fontRespon: false,
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 168,
              height: 40,
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(child: Container()),
                  isFavorited
                      ? GestureDetector(
                          onTap: () async {
                            setState(() {
                              isFavorited = false;
                            });
                            await _unlikesPost();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: C.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: C.dark1,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            setState(() {
                              isFavorited = true;
                            });
                            await _likesPost();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: C.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.favorite_outline_rounded,
                              color: C.dark1,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  _likesPost() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');
      var url =
          '${Url.baseurl}/profile/liked/?block_id=${widget.block_id}&user_id=${user_id}';
      print(url);

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.patch(Uri.parse(url), headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("success");
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  _unlikesPost() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');
      var url =
          '${Url.baseurl}/profile/unliked/?block_id=${widget.block_id}&user_id=${user_id}';
      print(url);

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.patch(Uri.parse(url), headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("success");
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
