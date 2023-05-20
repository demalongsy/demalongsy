import 'dart:io';
import 'package:demalongsy/base_URL/url.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WidgetSuggest extends StatefulWidget {
  final String category;
  const WidgetSuggest({Key? key, required this.category}) : super(key: key);

  @override
  State<WidgetSuggest> createState() => _WidgetSuggestState();
}

class _WidgetSuggestState extends State<WidgetSuggest> {
  bool isLoading = true;
  List<Map<String, dynamic>> data = [];

  _getData() async {
    var url = '${Url.baseurl}/similarStyle?type=${widget.category}';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var _data = convert.jsonDecode(response.body);

      (_data["data"] as List).map((e) => data.add(e)).toList();

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getData();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 2),
                child: Poppins(
                  text: "Category:",
                  size: 14,
                  color: C.textDefault2,
                  fontWeight: FW.regular,
                  letterspacing: 0.4,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: C.secondaryDefault,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
                      child: Poppins(
                        text: widget.category,
                        size: 13,
                        color: C.textDefault,
                        fontWeight: FW.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          isLoading
              ? Center(
                  child: Image.asset(
                    "assets/images/loading.gif",
                    height: 48,
                    width: 48,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
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
                                  data[index]['image'],
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
                                  padding: EdgeInsets.only(right: 8, bottom: 3),
                                  child: Poppins(
                                    text: data[index]['product_brand'],
                                    size: 18,
                                    color: C.textDefault,
                                    fontWeight: FW.bold,
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
                                    text: data[index]['description'],
                                    size: 12,
                                    color: C.textDefault,
                                    fontWeight: FW.light,
                                    letterspacing: 0.64,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                )
        ],
      ),
    );
  }
}
