import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class ShowStyle extends StatefulWidget {
  final String img;
  final String id;
  final bool isSaved;
  const ShowStyle(
      {Key? key, required this.img, required this.id, required this.isSaved})
      : super(key: key);

  @override
  State<ShowStyle> createState() => _ShowStyleState();
}

class _ShowStyleState extends State<ShowStyle> {
  bool showDatail = false;
  bool isSaved = false;

  @override
  void initState() {
    setState(() {
      isSaved = widget.isSaved;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 30),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 115,
                    height: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.img,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(child: Container()),
                              isSaved
                                  ? GestureDetector(
                                      onTap: () async {
                                        await _unSaveStyle();
                                        setState(() {
                                          isSaved = false;
                                        });
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          color: C.styletag,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.bookmark,
                                          color: C.dark1,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        await _saveStyle();
                                        setState(() {
                                          isSaved = true;
                                        });
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          color: C.styletag,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.bookmark_border_rounded,
                                          color: C.dark1,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: C.secondaryDefault,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 8, right: 8, bottom: 3),
                            child: Poppins(
                              text: "Style match",
                              size: 18,
                              color: C.textDefault,
                              fontWeight: FW.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Poppins(
                            overflow: true,
                            maxLines: 2,
                            text: "Style guide of your result suggest item.",
                            size: 12,
                            color: C.textDefault,
                            fontWeight: FW.light,
                            letterspacing: 0.64,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _saveStyle() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');
      var url =
          '${Url.baseurl}/similarStyle/saved?id=${widget.id}&user_id=${user_id}';
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

  _unSaveStyle() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');
      var url =
          '${Url.baseurl}/similarStyle/unsaved?id=${widget.id}&user_id=${user_id}';
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
