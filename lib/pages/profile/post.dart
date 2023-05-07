import 'package:demalongsy/models/data_mockup_for_post.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
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
                          imgPath: postDesc[index].imgPath,
                          isLiked: true));
                }),
          ),
        ),
      ),
    );
  }
}
