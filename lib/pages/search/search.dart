import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/models/all_posts.dart';
import 'package:demalongsy/models/all_users.dart';
import 'package:demalongsy/pages/another/another_profile.dart';

import 'package:demalongsy/pages/post/view_post.dart';

import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom/toolkit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Search extends StatefulWidget {
  final String param;
  const Search({Key? key, required this.param}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  TextEditingController _searchController = new TextEditingController();
  String _searchInput = '';
  bool x = false;

  late TabController controller;
  bool isLoading = true;
  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  Future<List<AllUsers>?> getUserList(String query) async {
    try {
      var url = '${Url.baseurl}/profile';

      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> _data = convert.jsonDecode(response.body);
        List results = _data["data"];

        return results.map((e) => AllUsers.fromJson(e)).where((val) {
          final name = val.name.toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList();
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<AllPosts>?> getPostList(String query) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');

      var url = '${Url.baseurl}/blocks?user_id=${user_id}';

      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> _data = convert.jsonDecode(response.body);
        List results = _data["data"];
        String tags = '';

        String inTags = query.replaceAll('#', '');

        return results.map((e) => AllPosts.fromJson(e)).where((val) {
          tags = '';
          final postTitle = val.title.toString().toLowerCase();
          final postDesc = val.desc.toString().toLowerCase();
          final postName = val.name.toString().toLowerCase();
          final tag = val.tags!.map((obj) {
            tags = obj.toString().toLowerCase() + tags;
          });
          print(tag);

          return postTitle.contains(query.toLowerCase()) ||
              postDesc.contains(query.toLowerCase()) ||
              postName.contains(query.toLowerCase()) ||
              tags.contains(inTags.toLowerCase());
        }).toList();
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _searchController..text = '${widget.param}';
      _searchInput = widget.param;
    });

    controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.white,
      appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          backgroundColor: C.white,
          elevation: 0.0,
          title: Column(
            children: [
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: C.dark2,
                        size: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      // width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _searchInput = value;
                            x = true;
                          });
                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: C.disableField,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: C.disableField),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: C.infoDefault),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: _searchInput.isNotEmpty
                                  ? C.disableTextfield
                                  : C.disableTextfield,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 0),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: SvgPicture.asset(
                                'assets/images/search-icon-grey.svg',
                                alignment: Alignment.center,
                                fit: BoxFit.fill,
                              ),
                            ),
                            suffixIcon: _searchInput.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      setState(() {
                                        _searchInput = '';
                                      });
                                    },
                                    child: const Align(
                                      widthFactor: 0.5,
                                      heightFactor: 1.0,
                                      child: Icon(
                                        Icons.close,
                                      ),
                                    ),
                                  )
                                : null),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: C.dark1,
                          fontWeight: FW.regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TabBar(
                labelColor: Colors.black,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.0),
                  insets: EdgeInsets.symmetric(horizontal: 110.0, vertical: 0),
                ),
                indicatorColor: C.dark1,
                labelStyle: const TextStyle(fontWeight: FW.bold, fontSize: 14),
                controller: controller,
                tabs: const [
                  Tab(
                    text: "Post",
                  ),
                  Tab(
                    text: "Account",
                  )
                ],
              ),
            ],
          )),
      body: TabBarView(controller: controller, children: [
        //post
        SingleChildScrollView(
          child: FutureBuilder<List<AllPosts>?>(
              future: getPostList(_searchInput),
              builder: (context, snapshot) {
                var data = snapshot.data;
                if (!snapshot.hasData) {
                  return Center(
                    child: Image.asset(
                      "assets/images/loading.gif",
                      height: 48,
                      width: 48,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 298,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, index) {
                      return ShowPost(
                        topic: data[index].title!,
                        name: data[index].name!,
                        imgPath: data[index].images![0],
                        isLiked: data[index].isLiked!,
                        block_id: data[index].id!,
                        author_id: data[index].authorId!,
                        tags: data[index].tags!,
                        author_username: data[index].username!,
                        imgAuthor: data[index].imgAuthor!,
                      );
                    },
                  ),
                );
              }),
        ),
        //account
        SingleChildScrollView(
          child: FutureBuilder<List<AllUsers>?>(
              future: getUserList(_searchInput),
              builder: (context, snapshot) {
                var data = snapshot.data;
                if (!snapshot.hasData) {
                  return Center(
                    child: Image.asset(
                      "assets/images/loading.gif",
                      height: 48,
                      width: 48,
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data!.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 24),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: NetworkImage(data[index]
                                          .images ??
                                      "https://img.freepik.com/free-icon/user_318-159711.jpg"),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Poppins(
                                  text: '${data[index].name}',
                                  size: 14,
                                  color: C.dark1,
                                  fontWeight: FW.bold),
                            ],
                          )),
                    );
                  }),
                );
              }),
        ),
      ]),
    );
  }
}
