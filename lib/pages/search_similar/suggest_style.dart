// import 'dart:io';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:demalongsy/custom/toolkit.dart';
// //import 'package:url_launcher/url_launcher.dart';

// import 'package:demalongsy/custom/widget/font.dart';

// class SuggestStylePage extends StatefulWidget {
//   final File image;
//   final bool? isformPost;
//   const SuggestStylePage(
//       {Key? key, required this.image, this.isformPost = false})
//       : super(key: key);
//   @override
//   _SuggestStylePageState createState() => _SuggestStylePageState();
// }

// class _SuggestStylePageState extends State<SuggestStylePage> {
//   // Image

//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//   }

//   // _launchURL() async {
//   //   const url = 'https://google.com';
//   //   if (await canLaunch(url)) {
//   //     await launch(url);
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SafeArea(
//         child: Scaffold(
//           backgroundColor: C.white,
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(50),
//             child: AppBar(
//               backgroundColor: C.white,
//               elevation: 0,
//               title: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                         child: const Icon(
//                           Icons.arrow_back_ios_rounded,
//                           color: C.dark2,
//                           size: 16.0,
//                         ),
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         }),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 20),
//                       child: Poppins(
//                         text: "Similar Items",
//                         size: 20,
//                         color: C.dark1,
//                         fontWeight: FW.bold,
//                         letterspacing: 0.64,
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Center(
//                   child: SizedBox(
//                     height: 200,
//                     width: 160,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(16.0),
//                         child: widget.isformPost ?? false
//                             ? Image.network(
//                                 "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg",
//                                 // fit: BoxFit.cover,
//                               )
//                             : Image.file(
//                                 widget.image,
//                                 // fit: BoxFit.cover,
//                               )),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 30),
//                   child: Poppins(
//                     text: "Your similar items list",
//                     size: 12,
//                     color: C.textDefault,
//                     fontWeight: FW.bold,
//                   ),
//                 ),
//                 const Divider(
//                   color: Colors.black,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 30,
//                     ),
//                     Container(
//                       width: 115,
//                       height: 115,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                         // shape: BoxShape.circle,
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(
//                             "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg",
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: C.secondaryDefault,
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: const Padding(
//                               padding: EdgeInsets.only(
//                                   left: 8, right: 8, top: 3, bottom: 3),
//                               child: Poppins(
//                                 text: "Givenchy",
//                                 size: 18,
//                                 color: C.textDefault,
//                                 fontWeight: FW.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(right: 10),
//                             child: Poppins(
//                               overflow: false,
//                               text:
//                                   "Silk women pants inspire from 90s styleeeeeeeeeeeeeeee",
//                               size: 12,
//                               color: C.textDefault,
//                               fontWeight: FW.light,
//                               letterspacing: 0.64,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 30),
//                   child: Poppins(
//                     text: "Suggest items",
//                     size: 12,
//                     color: C.textDefault,
//                     fontWeight: FW.bold,
//                   ),
//                 ),
//                 const Divider(
//                   color: Colors.black,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30, top: 10),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.2,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 5,
//                       // imageList.length + 1 > 10 ? 10 : imageList.length + 1,
//                       itemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                           onTap: () {
//                             // _launchURL();
//                           },
//                           child: Container(
//                             padding: EdgeInsets.only(right: 10),
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             height: MediaQuery.of(context).size.height * 0.17,
//                             child: Stack(
//                               children: [
//                                 Center(
//                                   child: Container(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.115,
//                                           // width: MediaQuery.of(context)
//                                           //         .size
//                                           //         .width *
//                                           //     0.5,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             image: DecorationImage(
//                                               image: NetworkImage(
//                                                   "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg"),
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                             top: 5,
//                                           ),
//                                           child: Poppins(
//                                             overflow: true,
//                                             maxLines: 2,
//                                             textAlign: TextAlign.center,
//                                             text: "Denim casual pants",
//                                             size: 12,
//                                             color: C.textDefault,
//                                             fontWeight: FW.light,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//====================================================================

import 'dart:io';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/search_similar/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class SuggestStylePage extends StatefulWidget {
  final File image;
  final bool isFormPost;

  const SuggestStylePage(
      {Key? key, required this.image, required this.isFormPost})
      : super(key: key);

  @override
  _SuggestStylePageState createState() => _SuggestStylePageState();
}

class _SuggestStylePageState extends State<SuggestStylePage> {
  List? _outputs;
  File? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

    classifyImage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachable Machine Learning'),
      ),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null
                      ? Image.file(widget.image)
                      : Image.file(widget.image),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(createTransitionRoute(
                              test(
                                image: widget.image,
                                isFormPost: false,
                              ),
                              1,
                              0));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.amber,
                    ),
                  ),
                  _outputs != null
                      ? Text(
                          "Kuay",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            background: Paint()..color = Colors.white,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: pickImage,
      //   child: Icon(Icons.image),
      // ),
    );
  }

  // pickImage() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) return null;
  //   setState(() {
  //     _loading = true;
  //     _image = File(image.path);
  //     print(_image);
  //   });
  //   classifyImage(File(image.path));
  // }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _loading = false;
      _outputs = output;
      print(_outputs);
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/model.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  @override
  void dispose() {
    if (mounted) {
      Tflite.close();
    }

    super.dispose();
  }
}
