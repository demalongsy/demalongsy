import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  String? comment_msg = '';
  List filedata = [
    {
      'name': 'K.Payongdech',
      'pic':
          'https://i.pinimg.com/564x/c1/81/86/c1818649d2f39a34255590cc8a306010.jpg',
      'message': 'ไอเดียเข้าใจง่ายน่าสนใจมากค่ะ มีอะไรมาแชร์กันได้นะคะ',
      'date': 'Nov 1'
    },
    {
      'name': 'Geeki',
      'pic':
          'https://i.pinimg.com/736x/a4/06/a8/a406a886f6309cf8bbfd0f84bc474601.jpg',
      'message': 'Good content มากครับ',
      'date': 'Nov 1'
    },
    {
      'name': 'นักเก็ต',
      'pic':
          'https://i.pinimg.com/564x/86/35/e3/8635e3cd91a8ccc932fbcfe18bf5180e.jpg',
      'message': 'Very cool',
      'date': 'Nov 1'
    },
  ];
  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        Text('Owner content'),
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Poppins(
                  text: data[i]['name'],
                  size: 12,
                  color: C.dark3,
                  fontWeight: FW.bold),
              subtitle: Poppins(
                  overflow: false,
                  text: data[i]['message'],
                  size: 16,
                  color: C.dark1,
                  fontWeight: FW.regular),
              trailing: Poppins(
                  text: data[i]['date'],
                  size: 12,
                  color: C.dark3,
                  fontWeight: FW.regular),
            ),
          ),
      ],
    );
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
                Navigator.of(context).pop();
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Comment()),
        ),
      ),
    ));
  }

  Widget Comment() {
    return Column(
      children: [
        Expanded(child: commentChild(filedata)),
        SizedBox.shrink(),
        ListTile(
          tileColor: C.white,
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/564x/77/75/91/7775914a2211e7b57f222155007b66a0.jpg")),
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
                // border: !withBorder
                //     ? InputBorder.none
                //     : UnderlineInputBorder(
                //         borderSide: BorderSide(color: textColor!),
                //       ),
                hintText: 'Send a message...',
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Comment cannot be blank' : null,
            ),
          ),
          trailing: checkAllSpaces(comment_msg!)
              ? GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      print(commentController.text);
                      setState(() {
                        var value = {
                          'name': 'Jojee',
                          'pic':
                              'https://i.pinimg.com/564x/77/75/91/7775914a2211e7b57f222155007b66a0.jpg',
                          'message': commentController.text,
                          'date': 'Nov 1'
                        };
                        filedata.insert(0, value);
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
}
