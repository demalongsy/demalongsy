import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';

import 'package:demalongsy/pages/search/search.dart';
import 'package:demalongsy/pages/search/search_first_page.dart';
import 'package:demalongsy/pages/post/view_post.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class PostForYou extends StatefulWidget {
  const PostForYou({Key? key}) : super(key: key);

  @override
  State<PostForYou> createState() => _PostForYouState();
}

class _PostForYouState extends State<PostForYou> {
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

  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user_id = prefs.getString('user_id');

    setState(() {
      data.clear();
    });

    var url = '${Url.baseurl}/blocks/foryou?user_id=${user_id}';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.white,
      body: isLoading == true
          ? Center(
              child: Image.asset(
                "assets/images/loading.gif",
                height: 48,
                width: 48,
              ),
            )
          : RefreshIndicator(
              color: C.primaryDefault,
              backgroundColor: C.white,
              key: _refreshIndicatorKey,
              onRefresh: _getData,
              child: SingleChildScrollView(
                child: Padding(
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: false)
                                .push(createTransitionRoute(
                                    ViewPost(
                                      tags: data[index]["tags"]!,
                                      block_id: data[index]["id"]!,
                                      author_username: data[index]
                                          ["imgAuthor"]!,
                                      imgAuthor: data[index]["imgAuthor"]!,
                                    ),
                                    1,
                                    0));
                          },
                          child: ShowPost(
                              topic: data[index]["title"],
                              name: data[index]["name"],
                              imgAcc: data[index]["imgAuthor"],
                              imgPath: data[index]["images"][0],
                              isLiked: data[index]["isLiked"],
                              block_id: data[index]["id"],
                              author_id: data[index]["author_id"],
                              tags: data[index]["tags"],
                              author_username: data[index]["username"],
                              imgAuthor: data[index]["imgAuthor"]),
                        );
                      }),
                ),
              ),
            ),
    );
  }
}

//   _getData() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String? user_id = prefs.getString('user_id');

//       var url = '${Url.baseurl}/blocks/foryou?user_id=${user_id}';

//       var response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         var _data = convert.jsonDecode(response.body);
//         data = [];
//         (_data["data"] as List).map((e) => data.add(e)).toList();

//         setState(() {
//           isLoading = false;
//         });
//       } else {
//         print('err ==> ${response.statusCode}');
//       }
//     } catch (e) {
//       print(e);
//       isLoading = false;
//     }
//   }
// }
