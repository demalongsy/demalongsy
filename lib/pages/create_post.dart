import 'dart:io';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

  // Image
  final ImagePicker _picker = ImagePicker();
  List<File> imageList = [];
  File? image;

  Future selectImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(
        () {
          selectedImages.map((e) {
            if (imageList.length < 10) {
              imageList.add(File(e.path));
            }
          }).toList();
        },
      );
    }
  }

  Future takePhoto() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(
        () {
          this.image = imageTemporary;
          imageList.add(this.image!);
        },
      );
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: C.white,
          bottomSheet: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: SizedBox(
              height: 48,
              child: checkAllSpaces(_titleInput) && imageList.isNotEmpty
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              primary: C.secondaryDefault, // Background color
                              onPrimary: C
                                  .secondaryPressed, // Text Color (Foreground color)
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              elevation: 0.0,
                              shadowColor: Colors.transparent)
                          .copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)),
                      child: const Center(
                        child: Poppins(
                            text: "Post",
                            size: 16,
                            color: C.dark2,
                            fontWeight: FW.bold),
                      ),
                      onPressed: () {},
                    )
                  : const Button(
                      text: "Post",
                      fontWeight: FW.bold,
                      color: C.textDefault2,
                      size: 16,
                      boxColor: C.secondaryPressed,
                      boxHeight: 48,
                      haveBorder: false,
                      letterspacing: 0.64,
                    ),
            ),
          ),
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
                      },
                    ),
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
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
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
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  width: double.infinity,
                  height: 110,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        imageList.length + 1 > 10 ? 10 : imageList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == imageList.length) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(50),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: C.backgroundWhiteIvory,
                                border: Border.all(
                                  color: C.boderAddPhotos,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 150,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                bottom: BorderSide(
                                                    width: 0.8,
                                                    color: Colors.grey
                                                        .withOpacity(0.5)),
                                              )),
                                              child: ListTile(
                                                  onTap: () async {
                                                    Future.delayed(
                                                      const Duration(
                                                          seconds: 5),
                                                    );
                                                    Navigator.of(context).pop();
                                                    await takePhoto();
                                                  },
                                                  leading: const Icon(
                                                    Icons
                                                        .photo_camera_front_outlined,
                                                    color: Colors.black,
                                                  ),
                                                  title: const Text(
                                                    "Take a photo",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  )),
                                            ),
                                            Container(
                                              child: ListTile(
                                                  onTap: () async {
                                                    Future.delayed(
                                                      const Duration(
                                                          seconds: 5),
                                                    );

                                                    Navigator.of(context).pop();
                                                    await selectImages();
                                                  },
                                                  leading: const Icon(
                                                    Icons
                                                        .photo_library_outlined,
                                                    color: Colors.black,
                                                  ),
                                                  title: const Text(
                                                    "Choose from gallery",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container(
                        padding: EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(50),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(
                                  imageList[index],
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          imageList.removeAt(index);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: C.secondaryDefault,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.close_rounded,
                                              size: 15,
                                              color: C.dark3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      onChanged: (value) => setState(() => _titleInput = value),
                      controller: _titleController,
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
                const SizedBox(height: 12),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
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
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
