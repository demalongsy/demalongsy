import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.backgroundWhiteIvory,
      body: RefreshIndicator(
        color: C.primaryDefault,
        backgroundColor: C.white,
        key: _refreshIndicatorKey,
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          child: isLoading == true
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
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 298,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, index) {
                      return ShowPost(
                          topic: data[index]["title"],
                          name: data[index]["name"],
                          imgAcc: data[index]["imgAuthor"],
                          imgPath: data[index]["images"][0],
                          isLiked: data[index]["isLiked"],
                          block_id: data[index]["id"],
                          author_id: data[index][" author_id"],
                          tags: data[index]["tags"],
                          author_username: data[index]["username"],
                          imgAuthor: data[index]["imgAuthor"]);
                    },
                  ),
                ),
        ),
      ),
    );
  }

  _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');

      var url = '${Url.baseurl}/profile/viewprofile/post?user_id=${user_id}';

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var _data = convert.jsonDecode(response.body);
        data = [];
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
}
