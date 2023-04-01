import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/post/view_post.dart';
import 'package:flutter/material.dart';

class ShowPost extends StatefulWidget {
  final String topic;
  final String name;
  final String imgAcc;
  final String imgPath;
  const ShowPost(
      {Key? key,
      required this.topic,
      required this.name,
      required this.imgAcc,
      required this.imgPath})
      : super(key: key);

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context, rootNavigator: false)
            .push(createTransitionRoute(ViewPost(), 1, 0));
      }),
      child: Container(
        //width: 168,
        height: 289,
        decoration: BoxDecoration(
            color: C.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 198,
                //width: 168,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  image: DecorationImage(
                      image: NetworkImage(widget.imgPath), fit: BoxFit.fill),
                ),
              ),
              Container(
                height: 57,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Poppins(
                    text: widget.topic,
                    size: 14,
                    color: C.dark1,
                    fontWeight: FW.bold,
                    letterspacing: 0.64,
                    maxLines: 2,
                    fontRespon: false,
                  ),
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
                      backgroundImage: NetworkImage(widget.imgAcc),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Poppins(
                      text: widget.name,
                      size: 10,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      letterspacing: 0.64,
                      maxLines: 1,
                      fontRespon: false,
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
