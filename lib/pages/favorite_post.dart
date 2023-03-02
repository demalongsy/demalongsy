import 'package:demalongsy/models/data_mockup_for_post.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';

class FavoritePosts extends StatefulWidget {
  const FavoritePosts({super.key});

  @override
  State<FavoritePosts> createState() => _FavoritePostsState();
}

class _FavoritePostsState extends State<FavoritePosts> {
  List<Post> postDesc = allPost;

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
    );
  }
}
