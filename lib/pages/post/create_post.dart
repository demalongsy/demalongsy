import 'dart:convert';
import 'dart:io';
import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/models/profile_model.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class Hastag {
  final int id;
  final String name;

  Hastag({
    required this.id,
    required this.name,
  });
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  String _titleInput = '';
  ProfileApi? _data;
  bool isLoading = true;
  bool isLoadingCreatePost = false;
  bool isChecked = false;

  Future<ProfileApi?> _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');

      var url = '${Url.baseurl}/profile/${username}';

      var response = await http.get(Uri.parse(url));

      _data = profileApiFromJson(response.body);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _getData();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // mock data
  static List<Hastag> _hastags = [
    Hastag(id: 1, name: "Vintage 90s"),
    Hastag(id: 2, name: "Y2K"),
    Hastag(id: 3, name: "All black"),
    Hastag(id: 4, name: "Korean"),
    Hastag(id: 5, name: "American"),
    Hastag(id: 6, name: "Minimal"),
    Hastag(id: 7, name: "Boyish"),
    Hastag(id: 8, name: "Fairy"),
    Hastag(id: 9, name: "Business"),
  ];

  // static List<String> _hastags = [
  //   ("#Vintage 90s"),
  //   ("#Y2K"),
  //   ("#All black"),
  //   ("#Korean"),
  //   ("#American"),
  //   ("#Minimal"),
  // ];

  final _items = _hastags
      .map((hastag) => MultiSelectItem<Hastag>(hastag, '#${hastag.name}'))
      .toList();
  List<Hastag> _selectedHastags = [];
  List<String> hashtagStrings = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

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
            if (imageList.length < 5) {
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
                        Navigator.pop(context, true);
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
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
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
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff74EDED),
                                backgroundImage: NetworkImage(isLoading
                                    ? "https://img.freepik.com/free-icon/user_318-159711.jpg"
                                    : _data?.imgAuthor ??
                                        'https://img.freepik.com/free-icon/user_318-159711.jpg'),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Poppins(
                                      text: isLoading ? "..." : _data!.name!,
                                      maxLines: 1,
                                      size: 16,
                                      color: C.dark1,
                                      fontWeight: FW.bold),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Poppins(
                                      text: isLoading
                                          ? "..."
                                          : "@${_data!.username}",
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
                            imageList.length + 1 > 5 ? 5 : imageList.length + 1,
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      await takePhoto();
                                                    },
                                                    leading: const Icon(
                                                      Icons
                                                          .photo_camera_front_outlined,
                                                      color: Colors.black,
                                                    ),
                                                    title: const Poppins(
                                                        text: "Take a photo",
                                                        size: 14,
                                                        color: C.dark2,
                                                        fontWeight: FW.regular),
                                                  ),
                                                ),
                                                Container(
                                                  child: ListTile(
                                                    onTap: () async {
                                                      Future.delayed(
                                                        const Duration(
                                                            seconds: 5),
                                                      );

                                                      Navigator.of(context)
                                                          .pop();
                                                      await selectImages();
                                                    },
                                                    leading: const Icon(
                                                      Icons
                                                          .photo_library_outlined,
                                                      color: Colors.black,
                                                    ),
                                                    title: const Poppins(
                                                        text:
                                                            "Choose from gallery",
                                                        size: 14,
                                                        color: C.dark2,
                                                        fontWeight: FW.regular),
                                                  ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                          onChanged: (value) =>
                              setState(() => _titleInput = value),
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
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
                          controller: _descController,
                          decoration: InputDecoration(
                            hintText: "Write your text",
                            hintStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FW.light,
                              color: C.disableTextfield,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: MultiSelectDialogField<Hastag>(
                        // Search in dialog
                        searchable: true,
                        searchIcon: const Icon(
                          Icons.search,
                          size: 18,
                        ),
                        searchTextStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FW.light,
                          color: C.dark2,
                        ),
                        // Hight Dialog
                        dialogHeight: 200,
                        // List in dialog
                        items: _items,
                        itemsTextStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FW.light,
                          color: C.dark2,
                        ),
                        title: const Poppins(
                            text: "Select Your Hastags",
                            size: 14,
                            color: C.dark2,
                            fontWeight: FW.bold),
                        selectedColor: C.secondaryDefault,
                        cancelText: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FW.light,
                            color: C.disableTextfield,
                          ),
                        ),
                        confirmText: const Text(
                          "OK",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FW.bold,
                            color: C.primaryDefault,
                          ),
                        ),
                        selectedItemsTextStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FW.light,
                          color: C.dark2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(
                            color: C.dark2,
                            width: 1,
                          ),
                        ),
                        buttonIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: C.dark2,
                        ),
                        buttonText: const Text(
                          "# Hastags",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FW.bold,
                            color: C.dark2,
                          ),
                        ),
                        onConfirm: (values) {
                          setState(() {
                            _selectedHastags = values;
                            hashtagStrings =
                                values.map((hastag) => hastag.name).toList();
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          chipColor: C.secondaryDefault,
                          textStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FW.bold,
                            color: C.dark2,
                          ),
                          icon: const Icon(
                            Icons.close,
                            color: C.dark2,
                            size: 14,
                          ),
                          onTap: (value) {
                            setState(() {
                              _selectedHastags.remove(value);
                              hashtagStrings.remove(value.name.toString());
                            });
                          },
                        ),
                      ),
                    ),
                    _selectedHastags.length > 0
                        ? SizedBox(height: 80)
                        : SizedBox(height: 130),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 20),
                      child: SizedBox(
                        height: 48,
                        child: checkAllSpaces(_titleInput) &&
                                imageList.isNotEmpty &&
                                hashtagStrings.length > 0
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                        primary: C
                                            .secondaryDefault, // Background color
                                        onPrimary: C
                                            .secondaryPressed, // Text Color (Foreground color)
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent)
                                    .copyWith(
                                        elevation:
                                            ButtonStyleButton.allOrNull(0.0)),
                                child: Center(
                                  child: isChecked
                                      ? CircularProgressIndicator()
                                      : Poppins(
                                          text: "Post",
                                          size: 16,
                                          color: C.dark2,
                                          fontWeight: FW.bold),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    isChecked = true;
                                  });
                                  Map<dynamic, dynamic> body = {
                                    'name': _data!.name,
                                    'username': _data!.username,
                                    'author_id': _data!.userId,
                                    'imgAuthor': _data!.imgAuthor ??
                                        'https://img.freepik.com/free-icon/user_318-159711.jpg',
                                    'title': _titleController.text,
                                    'desc': _descController.text,
                                    'tags': '${hashtagStrings}'
                                  };

                                  await _createPost(body, imageList);

                                  if (isLoadingCreatePost) {
                                    Navigator.pop(context, true);
                                  }
                                },
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _createPost(Map<dynamic, dynamic> body, List<File> files) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var url = '${Url.baseurl}/blocks/create';

    var req = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    req.headers['Authorization'] = 'Bearer $token';

    body.forEach((key, value) {
      req.fields[key] = value;
    });

    for (var file in files) {
      var stream = http.ByteStream(Stream.castFrom(file.openRead()));
      var length = await file.length();
      var multipartFile =
          http.MultipartFile('images', stream, length, filename: file.path);

      req.files.add(multipartFile);
    }

    var response = await req.send();
    if (response.statusCode == 200) {
      print('Files uploaded successfully');
      setState(() {
        isLoadingCreatePost = true;
        isChecked = false;
      });
    } else {
      print('Error uploading files: ${response.statusCode}');
    }
  }
}
