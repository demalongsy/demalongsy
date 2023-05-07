import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../custom/toolkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class Tags extends StatefulWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  int tag = 1;

  List<String> tags = [];

  List<String> options = [
    'Vintage 90s',
    'All black',
    'American',
    'Minimal',
    'Fairy',
    'Korean',
    'Y2K',
    'Boyish',
    'Business'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        backgroundColor: C.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: C.white,
            elevation: 0,
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: C.primaryDefault,
              child: SvgPicture.asset(
                "assets/images/bg-choose-fav.svg",
                fit: BoxFit.fill,
              ),
            ),
            ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Spectral(
                    text: "Choose",
                    color: C.dark1,
                    fontWeight: FW.bold,
                    size: 36,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Spectral(
                    text: "your favorite style",
                    color: C.dark1,
                    fontWeight: FW.bold,
                    size: 36,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Spectral(
                    text: "Fantastic to start to use application!",
                    color: C.dark1,
                    fontWeight: FW.light,
                    size: 14,
                  ),
                ),
                ChipsChoice<String>.multiple(
                  value: tags,
                  onChanged: (val) {
                    setState(() {
                      tags = val;
                    });
                  },
                  choiceItems: C2Choice.listFrom(
                      source: options, value: (i, v) => v, label: (i, v) => v),
                  //active
                  choiceActiveStyle: const C2ChoiceStyle(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: C.primaryDefault),
                    backgroundColor: C.dark1,
                    color: C.primaryDefault,
                    showCheckmark: false,
                    borderColor: Color(0xFF0B6E40),
                    avatarBorderColor: C.primaryDefault,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    avatarBorderShape: OutlineInputBorder(),
                  ),
                  choiceStyle: const C2ChoiceStyle(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: C.dark1,
                    borderColor: C.dark1,
                    labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    avatarBorderColor: C.primaryDefault,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  wrapped: true,
                  textDirection: TextDirection.ltr,
                  choiceAvatarBuilder: (data) {
                    return data.selected
                        ? SvgPicture.asset(
                            'assets/images/circle-check.svg',
                            width: 24,
                            height: 24,
                          )
                        : SvgPicture.asset(
                            'assets/images/circle-regular.svg',
                            width: 24,
                            height: 24,
                          );
                  },
                ),
              ],
            )
          ],
        ),
        bottomNavigationBar: tags.isNotEmpty && tags.length > 0
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: GestureDetector(
                  onTap: () async {
                    Map<String, dynamic> body = {"tags": tags};

                    await _selectTag(body);

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Navbar()));
                  },
                  child: const Button(
                    text: "Get Start",
                    fontWeight: FW.bold,
                    color: C.dark2,
                    size: 16,
                    boxColor: C.secondaryDefault,
                    boxHeight: 48,
                    haveBorder: false,
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: Button(
                  text: "Get Start",
                  fontWeight: FW.bold,
                  color: C.dark2,
                  size: 16,
                  boxColor: C.secondaryPressed,
                  boxHeight: 48,
                  haveBorder: false,
                ),
              ),
      ),
    ));
  }

  _selectTag(Map<String, dynamic> body) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? user_id = prefs.getString('user_id');
      var url = '${Url.baseurl}/profile/selectedTags/${user_id}';

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.patch(Uri.parse(url),
          headers: header, body: convert.jsonEncode(body));

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
