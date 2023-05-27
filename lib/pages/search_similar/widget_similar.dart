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

class WidgetSimilar extends StatefulWidget {
  final String id;
  const WidgetSimilar({Key? key, required this.id}) : super(key: key);

  @override
  State<WidgetSimilar> createState() => _WidgetSimilarState();
}

class _WidgetSimilarState extends State<WidgetSimilar> {
  bool isLoading = true;
  ViewSimilar? data;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getData();
  }

  _getData() async {
    var url = '${Url.baseurl}/similarStyle/${widget.id}';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      data = viewSimilarFromJson(response.body);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Image.asset(
              "assets/images/loading.gif",
              height: 48,
              width: 48,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        image: NetworkImage(
                          data!.image!,
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
                        Container(
                          decoration: BoxDecoration(
                            color: C.secondaryDefault,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 3, bottom: 3),
                            child: Poppins(
                              text: data!.productBrand!,
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
                            text: data!.description!,
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
                height: 45,
              ),
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
                itemCount: 2,
                itemBuilder: ((context, index) {
                  return ShowStyle();
                }),
              )
            ],
          );
  }
}
