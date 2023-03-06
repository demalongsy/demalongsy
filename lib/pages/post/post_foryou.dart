import 'package:demalongsy/models/data_mockup_for_post.dart';
import 'package:demalongsy/pages/search/search.dart';
import 'package:demalongsy/pages/search/search_first_page.dart';
import 'package:demalongsy/pages/post/view_post.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';

class PostForYou extends StatefulWidget {
  const PostForYou({super.key});

  @override
  State<PostForYou> createState() => _PostForYouState();
}

class _PostForYouState extends State<PostForYou> {
  List<Post> postDesc = allPost;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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
                itemCount: postDesc.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                      onTap: () {},
                      child: ShowPost(
                          topic: postDesc[index].topic,
                          name: postDesc[index].name,
                          imgAcc: postDesc[index].imgAcc,
                          imgPath: postDesc[index].imgPath));
                }),
          ),
        ),
      ),
    );
  }
}