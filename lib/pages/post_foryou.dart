import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/models/data_mockup_for_post.dart';
import 'package:demalongsy/pages/search.dart';
import 'package:demalongsy/pages/search_first_page.dart';
import 'package:demalongsy/pages/view_post.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';

class PostForYou extends StatefulWidget {
  const PostForYou({super.key});

  @override
  State<PostForYou> createState() => _PostForYouState();
}

class _PostForYouState extends State<PostForYou> {
  List<Post> postDesc = allPost;
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: C.backgroundWhiteIvory,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 298,

                    //childAspectRatio: 3 / 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6),
                itemCount: 9,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text("${index}"),
                    ),
                  );
                }),
          ),
        ));
  }

  Widget AllPost(String topic, String name, String imgAcc, String imgPath) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context, rootNavigator: false)
            .push(createTransitionRoute(ViewPost(), 1, 0));
      }),
      child: Container(
        width: 168,
        height: 289,
        decoration: BoxDecoration(
            color: C.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: 198,
                width: 168,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  image: DecorationImage(
                      image: NetworkImage(imgPath), fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Poppins(
                  text: topic,
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                  letterspacing: 0.64,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Color(0xff74EDED),
                      backgroundImage: NetworkImage(imgAcc),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Poppins(
                      text: name,
                      size: 10,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      letterspacing: 0.64,
                      maxLines: 1,
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
                          onTap: () {
                            setState(() {
                              isFavorited = false;
                            });
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
                          onTap: () {
                            setState(() {
                              isFavorited = true;
                            });
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
}
