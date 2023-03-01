import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _titleController = new TextEditingController();
  String _titleInput = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: C.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: C.white,
              elevation: 0,
              title: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: C.dark2,
                            size: 16.0,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Poppins(
                          text: "Create Post",
                          size: 20,
                          color: C.dark1,
                          fontWeight: FW.bold,
                          letterspacing: 0.64,
                        ),
                      ),
                      Expanded(child: Container()),
                    ]),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff74EDED),
                            backgroundImage: NetworkImage(
                                "https://placeimg.com/640/480/people"),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Poppins(
                                  text: "K. Payongdech",
                                  maxLines: 1,
                                  size: 16,
                                  color: C.dark1,
                                  fontWeight: FW.bold),
                              SizedBox(
                                height: 4,
                              ),
                              Poppins(
                                  text: "@Dekdee2023_",
                                  maxLines: 2,
                                  size: 14,
                                  color: C.dark3,
                                  fontWeight: FW.light),
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  // onDoubleTap: () {
                  //   if (_titleController.text.isNotEmpty) {
                  //     _titleController.selection = TextSelection(
                  //         baseOffset: 0,
                  //         extentOffset: _titleController.text.length);
                  //   }
                  // },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 25, right: 25),
                    child: TextFormField(
                      // onChanged: (value) => setState(() => _titleInput = value),
                      // controller: _titleController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Title on your post",
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FW.light,
                          color: C.disableTextfield,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: C.textField),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: C.textField),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: C.textField,
                      ),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  // onDoubleTap: () {
                  //   if (_titleController.text.isNotEmpty) {
                  //     _titleController.selection = TextSelection(
                  //         baseOffset: 0,
                  //         extentOffset: _titleController.text.length);
                  //   }
                  // },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 25, right: 25),
                    child: TextFormField(
                      // onChanged: (value) => setState(() => _titleInput = value),
                      // controller: _titleController,
                      keyboardType: TextInputType.multiline,
                      // minLines: 1,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: "Write your text",
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FW.light,
                          color: C.disableTextfield,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: C.textField),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: C.textField),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: C.textField,
                      ),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
