import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostPage extends StatefulWidget {
  List<Map<String, dynamic>> allPost;
  PostPage({Key? key, required this.allPost});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Map<String, dynamic>> allPost = [];

  @override
  void initState() {
    setState(() {
      allPost = widget.allPost;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 298,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6),
          itemCount: allPost.length,
          itemBuilder: (BuildContext context, index) {
            return ShowPost(
                topic: allPost[index]["title"],
                name: allPost[index]["name"],
                imgPath: allPost[index]["images"][0],
                isLiked: allPost[index]["isLiked"],
                block_id: allPost[index]["id"],
                author_id: allPost[index][" author_id"],
                tags: allPost[index]["tags"],
                author_username: allPost[index]["username"],
                imgAuthor: allPost[index]["imgAuthor"]);
          },
        ),
      ),
    );
  }
}
