import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/models/profile_model.dart';
import 'package:demalongsy/models/view_post.dart';
import 'package:demalongsy/pages/another/another_profile.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class ViewComment extends StatefulWidget {
  final String block_id;
  final String imgAuthor;
  final String name;
  const ViewComment(
      {Key? key,
      required this.block_id,
      required this.imgAuthor,
      required this.name})
      : super(key: key);

  @override
  State<ViewComment> createState() => _CommentState();
}

class _CommentState extends State<ViewComment> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  String? comment_msg = '';
  ViewPostDetail? _postDetail;
  List<Map<String, dynamic>> filedata = [];
  ProfileApi? _data;
  bool isLoading = true;
  bool isLoadingPost = true;
  String date = '';
  String month = '';
  String? username = '';
  String? user_id = '';
  bool isLoadingProfile = true;
  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  Future<ProfileApi?> _getDataProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');

      var url = '${Url.baseurl}/profile/${username}';

      var response = await http.get(Uri.parse(url));

      _data = profileApiFromJson(response.body);
      setState(() {
        isLoadingProfile = true;
      });
    } catch (e) {
      print(e);
      isLoadingProfile = false;
    }
  }

  Future<void> _getPostDetail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? user_id = prefs.getString('user_id');
      final String? username = prefs.getString('username');
      final String? token = prefs.getString('token');

      var url =
          '${Url.baseurl}/blocks/view/${widget.block_id}?user_id=${user_id}';

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.get(Uri.parse(url), headers: header);
      _postDetail = viewPostDetailFromJson(response.body);

      setState(() {
        isLoadingPost = false;
      });
    } catch (e) {
      print(e);
      isLoadingPost = false;
    }
  }

  Future<void> _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      username = prefs.getString('username');
      user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');

      var url = '${Url.baseurl}/comment/viewcomment/${widget.block_id}';

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var _data = convert.jsonDecode(response.body);

        (_data["data"] as List).map((e) => filedata.add(e)).toList();

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _getData();
    _getPostDetail();
    _getDataProfile();
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: C.white,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: C.dark2,
                size: 16.0,
              ),
              onTap: () {
                Navigator.pop(context, true);
              },
            ),
            const SizedBox(
              width: 20,
            ),
            const Poppins(
                text: 'Comments',
                size: 20,
                color: C.dark1,
                fontWeight: FW.bold),
          ],
        ),
      ),
      body: Container(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Comment()),
      ),
    ));
  }

  Widget Comment() {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: commentImageParser(
                          imageURLorPath: NetworkImage(isLoadingPost
                              ? "https://img.freepik.com/free-icon/user_318-159711.jpg"
                              : _postDetail!.imgAuthor!))),
                ),
                title: Wrap(
                  children: [
                    Poppins(
                        text: isLoadingPost ? '...' : _postDetail!.name!,
                        size: 12,
                        color: C.dark3,
                        fontWeight: FW.bold),
                    const SizedBox(
                      width: 4,
                    ),
                    const Button(
                      text: "Creator",
                      fontWeight: FW.bold,
                      color: C.dark1,
                      size: 10,
                      boxColor: C.primaryDefault,
                      boxHeight: 18,
                      haveBorder: false,
                      declareWidth: true,
                      width: 56,
                    ),
                  ],
                ),
                subtitle: Poppins(
                    overflow: false,
                    text: isLoadingPost ? '...' : _postDetail!.desc!,
                    size: 16,
                    color: C.dark1,
                    fontWeight: FW.regular),
              ),
              const Divider(
                color: C.boderAddPhotos,
                thickness: 1,
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
                      itemCount: filedata.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 0.0),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: false)
                                    .push(createTransitionRoute(
                                        AnotherProfile(
                                          another_username: filedata[index]
                                              ["username"]!,
                                          another_id: filedata[index]
                                              ["author_id"]!,
                                        ),
                                        1,
                                        0));
                              },
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: commentImageParser(
                                        imageURLorPath: filedata[index]
                                            ["imgAuthor"])),
                              ),
                            ),
                            title: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createTransitionRoute(
                                          AnotherProfile(
                                            another_username: filedata[index]
                                                ['username'],
                                            another_id: filedata[index]
                                                ["author_id"],
                                          ),
                                          1,
                                          0));
                                },
                                child: Wrap(
                                  children: [
                                    Poppins(
                                        text: filedata[index]['name'],
                                        size: 12,
                                        color: C.dark3,
                                        fontWeight: FW.bold),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    filedata[index]['isOwnerPost']!
                                        ? const Button(
                                            text: "Creator",
                                            fontWeight: FW.bold,
                                            color: C.dark1,
                                            size: 10,
                                            boxColor: C.primaryDefault,
                                            boxHeight: 18,
                                            haveBorder: false,
                                            declareWidth: true,
                                            width: 56,
                                          )
                                        : Container()
                                  ],
                                )),
                            subtitle: Poppins(
                                overflow: false,
                                text: filedata[index]['desc'],
                                size: 16,
                                color: C.dark1,
                                fontWeight: FW.regular),
                            trailing: Poppins(
                                text: FormatDate(filedata[index]['date']),
                                size: 12,
                                color: C.dark3,
                                fontWeight: FW.regular),
                          ),
                        );
                      })
            ],
          ),
        )),
        SizedBox.shrink(),
        ListTile(
          tileColor: C.white,
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(isLoadingProfile
                    ? "https://img.freepik.com/free-icon/user_318-159711.jpg"
                    : _data!.img ??
                        "https://img.freepik.com/free-icon/user_318-159711.jpg")),
          ),
          title: Form(
            key: formKey,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  comment_msg = value;
                });
              },
              cursorColor: C.dark1,
              style: TextStyle(color: C.dark1),
              controller: commentController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: C.disableTextfield),
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: C.infoDefault),
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: 'Send a message...',
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Comment cannot be blank' : null,
            ),
          ),
          trailing: checkAllSpaces(comment_msg!)
              ? GestureDetector(
                  onTap: () async {
                    Map<String, dynamic> body = {
                      "reply_block_id": _postDetail!.blockId,
                      "isOwnerPost":
                          _postDetail!.username! == username ? true : false,
                      "desc": commentController.text,
                      "author_id": user_id,
                      "name": _data!.name,
                      "username": _data!.username,
                      "imgAuthor": _data!.img ??
                          "https://img.freepik.com/free-icon/user_318-159711.jpg"
                    };
                    _sentComments(body);
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        var value = {
                          'name': _data!.name,
                          'username': _data!.username,
                          'imgAuthor': _data!.img ??
                              "https://img.freepik.com/free-icon/user_318-159711.jpg",
                          'desc': commentController.text,
                          'date':
                              "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
                          'isOwnerPost':
                              _postDetail!.username! == _data!.username
                                  ? true
                                  : false
                        };
                        filedata.insert(0, value);
                        comment_msg = '';
                      });

                      commentController.clear();
                      FocusScope.of(context).unfocus();
                    } else {
                      print("Not validated");
                    }
                  },
                  child: const Button(
                    text: "Send",
                    fontWeight: FW.bold,
                    color: C.dark1,
                    size: 14,
                    boxColor: C.primaryDefault,
                    boxHeight: 40,
                    haveBorder: false,
                    declareWidth: true,
                    width: 56,
                  ),
                )
              : const Button(
                  text: "Send",
                  fontWeight: FW.bold,
                  color: C.disableTextfield,
                  size: 14,
                  boxColor: C.primaryDefault,
                  boxHeight: 40,
                  haveBorder: false,
                  declareWidth: true,
                  width: 56,
                ),
        )
      ],
    );
  }

  static ImageProvider commentImageParser({imageURLorPath}) {
    try {
      //check if imageURLorPath
      if (imageURLorPath is String) {
        if (imageURLorPath.startsWith('http')) {
          return NetworkImage(imageURLorPath);
        } else {
          return AssetImage(imageURLorPath);
        }
      } else {
        return imageURLorPath;
      }
    } catch (e) {
      //throw error
      throw Exception('Error parsing image: $e');
    }
  }

  FormatDate(String dateDB) {
    var splitDate = dateDB.split("/");

    date = int.parse(splitDate[1]) < 10
        ? '0${int.parse(splitDate[1])}'
        : '${splitDate[1]}';
    month = int.parse(splitDate[0]) == 1
        ? 'Jan'
        : int.parse(splitDate[0]) == 2
            ? 'Feb'
            : int.parse(splitDate[0]) == 3
                ? 'Mar'
                : int.parse(splitDate[0]) == 4
                    ? 'Apr'
                    : int.parse(splitDate[0]) == 5
                        ? 'May'
                        : int.parse(splitDate[0]) == 6
                            ? 'Jun'
                            : int.parse(splitDate[0]) == 7
                                ? 'Jul'
                                : int.parse(splitDate[0]) == 8
                                    ? 'Aug'
                                    : int.parse(splitDate[0]) == 9
                                        ? 'Sep'
                                        : int.parse(splitDate[0]) == 10
                                            ? 'Oct'
                                            : int.parse(splitDate[0]) == 11
                                                ? 'Nov'
                                                : 'Dec';

    return month + ' ' + date;
  }

  _sentComments(Map<String, dynamic> body) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      var url = '${Url.baseurl}/comment';

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.post(Uri.parse(url),
          headers: header, body: convert.jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = convert.jsonDecode(response.body);
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
