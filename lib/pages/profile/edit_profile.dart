import 'dart:io';
import 'dart:async';
import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _bioController = new TextEditingController();
  ProfileApi? _data;
  bool isLoading = true;
  final formKey = GlobalKey<FormState>();

  String _nameInput = '';
  String _emailInput = '';
  String _bioInput = '';
  String _usernameInput = '';
  bool isLoadingCreatePost = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  // Image
  File? image;

  Future<ProfileApi?> _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');

      var url = '${Url.baseurl}/profile/${username}';

      var response = await http.get(Uri.parse(url));

      _data = profileApiFromJson(response.body);
      setState(() {
        isLoading = false;
        setState(() {
          _nameController..text = _data!.name!;
          _bioController..text = _data?.bio ?? 'Welcome to Demalongsy!';
        });
      });
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  Future takePhoto(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      final image = await _picker.pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
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
            preferredSize: const Size.fromHeight(50),
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
                          }),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Poppins(
                          text: "Edit Profile",
                          size: 20,
                          color: C.dark1,
                          fontWeight: FW.bold,
                          letterspacing: 0.64,
                        ),
                      ),
                      Expanded(child: Container()),
                      checkAllSpaces(_nameInput) ||
                              checkAllSpaces(_emailInput) ||
                              checkAllSpaces(_bioInput) ||
                              image != null
                          ? GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isChecked = true;
                                });

                                if (_bioInput.isEmpty &&
                                    _nameInput.isNotEmpty) {
                                  Map<dynamic, dynamic> body = {
                                    'name': _nameController.text,
                                  };
                                  await _editProfile(body, image);
                                }

                                if (_bioInput.isNotEmpty &&
                                    _nameInput.isNotEmpty) {
                                  Map<dynamic, dynamic> body = {
                                    'name': _nameController.text,
                                    'bio': _bioController.text,
                                  };
                                  await _editProfile(body, image);
                                }

                                if (_bioInput.isNotEmpty &&
                                    _nameInput.isEmpty) {
                                  Map<dynamic, dynamic> body = {
                                    'bio': _bioController.text,
                                  };
                                  await _editProfile(body, image);
                                }

                                if (_nameInput.isEmpty &&
                                    _bioInput.isEmpty &&
                                    image!.path != null) {
                                  Map<dynamic, dynamic> body = {};
                                  await _editProfile(body, image);
                                }

                                if (isLoadingCreatePost) {
                                  Navigator.pop(context, true);
                                }
                              },
                              child: isChecked
                                  ? CircularProgressIndicator()
                                  : Poppins(
                                      text: "Save",
                                      size: 16,
                                      color: C.primaryDefault,
                                      fontWeight: FW.bold,
                                      letterspacing: 0.64,
                                    ),
                            )
                          : const Poppins(
                              text: "Save",
                              size: 16,
                              color: C.disableTextfield,
                              fontWeight: FW.bold,
                              letterspacing: 0.64,
                            ),
                    ]),
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    profilePhoto(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Poppins(
                          text: "Personal Infomation",
                          size: 12,
                          color: C.textDefault,
                          fontWeight: FW.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    TextFieldUsername(),
                    TextFieldName(""),
                    //TextFieldEmail("K. Payoungdech"),
                    TextFieldBio(isLoading
                        ? "Welcome to De'malongsy"
                        : _data?.bio ?? "Welcome to De'malongsy!"),
                    const SizedBox(
                      height: 80,
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

  Widget TextFieldUsername() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1, left: 30, right: 30),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          icon: const Poppins(
              text: "Username", size: 14, color: C.dark2, fontWeight: FW.light),
          hintText: isLoading ? '...' : '@${_data!.username}',
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FW.light,
            color: C.dark3,
          ),
          border: InputBorder.none,
          suffixIcon: Tooltip(
            richMessage: WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Container(
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: const Poppins(
                        text: "Can not be change",
                        size: 14,
                        color: C.dark1,
                        fontWeight: FW.regular))),
            decoration: ShapeDecoration(
              color: C.disableTextfield,
              shape: ToolTipCustomShape(),
            ),
            preferBelow: false,
            verticalOffset: 10,
            child: const Icon(
              Icons.info,
              size: 16,
              color: C.dark3,
            ),
          ),
        ),
        onSaved: (String? value) {},
      ),
    );
  }

  Widget TextFieldName(String placeholder) {
    return GestureDetector(
      onDoubleTap: () {
        if (_nameController.text.isNotEmpty) {
          _nameController.selection = TextSelection(
              baseOffset: 0, extentOffset: _nameController.text.length);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 30, right: 30),
        child: TextFormField(
          onChanged: (value) => setState(() => _nameInput = value),
          controller: _nameController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
            icon: const Poppins(
                text: "Name        ",
                size: 14,
                color: C.dark2,
                fontWeight: FW.light),
            hintText: isLoading ? "..." : "${_data!.name}",
            hintStyle: placeholder != ""
                ? const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FW.light,
                    color: C.textDefault,
                  )
                : const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FW.light,
                    color: C.disableTextfield,
                  ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: C.disableTextfield),
            ),
          ),
          onSaved: (String? value) {},
        ),
      ),
    );
  }

  Widget TextFieldEmail(String placeholder) {
    return GestureDetector(
      onDoubleTap: () {
        if (_emailController.text.isNotEmpty) {
          _emailController.selection = TextSelection(
              baseOffset: 0, extentOffset: _emailController.text.length);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28, left: 30, right: 30),
        child: TextFormField(
          onChanged: (value) => setState(() => _emailInput = value),
          controller: _emailController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
            icon: const Poppins(
                text: "Email         ",
                size: 14,
                color: C.dark2,
                fontWeight: FW.light),
            hintText: placeholder == "" ? "Email" : placeholder,
            hintStyle: placeholder != ""
                ? const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FW.light,
                    color: C.textDefault,
                  )
                : const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FW.light,
                    color: C.disableTextfield,
                  ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: C.disableTextfield),
            ),
          ),
          onSaved: (String? value) {},
        ),
      ),
    );
  }

  Widget TextFieldBio(String placeholder) {
    return GestureDetector(
      onDoubleTap: () {
        if (_bioController.text.isNotEmpty) {
          _bioController.selection = TextSelection(
              baseOffset: 0, extentOffset: _bioController.text.length);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 30, right: 30),
        child: TextFormField(
          onChanged: (value) => setState(() => _bioInput = value),
          controller: _bioController,
          maxLines: 8,
          maxLength: 80,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              icon: const Poppins(
                  text: "Bio             ",
                  size: 14,
                  color: C.dark2,
                  fontWeight: FW.light),
              hintText: placeholder == "" ? "Write your Bio" : placeholder,
              hintStyle: placeholder != ""
                  ? const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FW.light,
                      color: C.textDefault,
                    )
                  : const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FW.light,
                      color: C.disableTextfield,
                    ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: C.disableField),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: C.dark1),
              ),
              filled: true,
              fillColor: C.disableField,
              counterText:
                  '${(80 - _bioController.text.length).toString()} character',
              counterStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight: FW.light,
                color: C.disableTextfield,
              )),
        ),
      ),
    );
  }

  Widget profilePhoto() {
    return Center(
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            image == null
                ? Container(
                    width: 98,
                    height: 98,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          isLoading
                              ? 'https://img.freepik.com/free-icon/user_318-159711.jpg'
                              : _data?.imgAuthor ??
                                  'https://img.freepik.com/free-icon/user_318-159711.jpg',
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 98,
                    height: 98,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.file(
                        image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: C.secondaryDefault,
                  ),
                  child: const Icon(
                    Icons.mode_edit_rounded,
                    color: C.dark2,
                    size: 20,
                  ),
                )),
          ],
        ),
        onTap: () {
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 0.8, color: Colors.grey.withOpacity(0.5)),
                        )),
                        child: ListTile(
                            onTap: () async {
                              Future.delayed(Duration(seconds: 5));
                              Navigator.of(context).pop();
                              await takePhoto(ImageSource.camera);
                            },
                            leading: const Icon(
                              Icons.photo_camera_front_outlined,
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
                              Future.delayed(Duration(seconds: 5));
                              Navigator.of(context).pop();
                              await takePhoto(ImageSource.gallery);
                            },
                            leading: const Icon(
                              Icons.photo_library_outlined,
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
              });
        },
      ),
    );
  }

  _editProfile(Map<dynamic, dynamic> body, File? file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? user_id = prefs.getString('user_id');

    var url = '${Url.baseurl}/profile/edit/$user_id';

    var req = http.MultipartRequest(
      'PATCH',
      Uri.parse(url),
    );

    req.headers['Authorization'] = 'Bearer $token';

    if (body.isNotEmpty) {
      body.forEach((key, value) {
        req.fields[key] = value;
      });
    }

    if (file != null) {
      var stream = http.ByteStream(Stream.castFrom(file.openRead()));
      var length = await file.length();
      var multipartFile =
          http.MultipartFile('imgAuthor', stream, length, filename: file.path);

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

class ToolTipCustomShape extends ShapeBorder {
  final bool usePadding;
  ToolTipCustomShape({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 20));
    return Path()
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 8)))
      ..moveTo(rect.bottomCenter.dx + 30, rect.bottomCenter.dy)
      ..relativeLineTo(10, 20)
      ..relativeLineTo(10, -20)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
