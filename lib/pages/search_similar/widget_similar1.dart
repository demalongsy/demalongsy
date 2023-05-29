import 'dart:io';

import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/models/similar_product.dart';
import 'package:demalongsy/widget/showstyle.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
//import 'package:url_launcher/url_launcher.dart';

import 'package:demalongsy/custom/widget/font.dart';

import 'package:tflite/tflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class WidgetSimilar1 extends StatefulWidget {
  final String color;
  final String category;
  const WidgetSimilar1({Key? key, required this.color, required this.category})
      : super(key: key);

  @override
  State<WidgetSimilar1> createState() => _WidgetSimilar1State();
}

class _WidgetSimilar1State extends State<WidgetSimilar1> {
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataStyle = [];
  bool isLoading = true;
  bool isLoadingStyle = true;
  @override
  void initState() {
    print(widget.color);
    print(widget.category);
    _getData();
    _getStyle();
    // TODO: implement initState
    super.initState();
  }

  _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      setState(() {
        data.clear();
      });
      var url =
          '${Url.baseurl}/similarStyle/getsuggest?color=${widget.color}&category=${widget.category}';

      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var _data = convert.jsonDecode(response.body);

        (_data["data"] as List).map((e) => data.add(e)).toList();

        setState(() {
          isLoading = false;
        });
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  _getStyle() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      setState(() {
        dataStyle.clear();
      });
      var url =
          '${Url.baseurl}/similarStyle/styleguide?color=${widget.color}&category=${widget.category}&user_id=${user_id}';

      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var _data = convert.jsonDecode(response.body);

        (_data["data"] as List).map((e) => dataStyle.add(e)).toList();

        setState(() {
          isLoadingStyle = false;
        });
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      isLoadingStyle = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        isLoading == true
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    "assets/images/loading.gif",
                    height: 45,
                    width: 45,
                  ),
                ),
              )
            : data.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 115,
                                height: 115,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  // shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data[index]["image"]),
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color: C.secondaryDefault,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 3,
                                            bottom: 3),
                                        child: Poppins(
                                          text: data[index]["product_brand"],
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
                                        text: data[index]["description"],
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
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    })
                : Center(
                    child: Poppins(
                      text: "There is no data in the system.",
                      size: 14,
                      color: C.textDefault,
                      fontWeight: FW.bold,
                    ),
                  ),
        const SizedBox(
          height: 45,
        ),
        isLoadingStyle == true
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    "assets/images/loading.gif",
                    height: 45,
                    width: 45,
                  ),
                ),
              )
            : dataStyle.length > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Poppins(
                          text: "Style guide",
                          size: 12,
                          color: C.textDefault,
                          fontWeight: FW.bold,
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dataStyle.length,
                        itemBuilder: ((context, index) {
                          return ShowStyle(
                              img: dataStyle[index]["image"],
                              id: dataStyle[index]["id"],
                              isSaved: dataStyle[index]["isSaved"]);
                        }),
                      )
                    ],
                  )
                : Container()
      ],
    );
  }
}
