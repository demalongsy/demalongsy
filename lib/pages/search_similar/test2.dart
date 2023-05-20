// import 'dart:io';
// import 'package:demalongsy/custom/widget/page_transition.dart';
// import 'package:demalongsy/pages/search_similar/test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

// class SuggestStylePage extends StatefulWidget {
//   final File image;
//   final bool isFormPost;

//   const SuggestStylePage(
//       {Key? key, required this.image, required this.isFormPost})
//       : super(key: key);

//   @override
//   _SuggestStylePageState createState() => _SuggestStylePageState();
// }

// class _SuggestStylePageState extends State<SuggestStylePage> {
//   List? _outputs;
//   File? _image;
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loading = true;

//     loadModel().then((value) {
//       setState(() {
//         _loading = false;
//       });
//     });

//     classifyImage(widget.image);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Teachable Machine Learning'),
//       ),
//       body: _loading
//           ? Container(
//               alignment: Alignment.center,
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _image == null
//                       ? Image.file(widget.image)
//                       : Image.file(widget.image),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context, rootNavigator: true)
//                           .push(createTransitionRoute(
//                               test(
//                                 image: widget.image,
//                                 isFormPost: false,
//                               ),
//                               1,
//                               0));
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       color: Colors.amber,
//                     ),
//                   ),
//                   _outputs != null
//                       ? Text(
//                           "Kuay",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20.0,
//                             background: Paint()..color = Colors.white,
//                           ),
//                         )
//                       : Container()
//                 ],
//               ),
//             ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: pickImage,
//       //   child: Icon(Icons.image),
//       // ),
//     );
//   }

//   // pickImage() async {
//   //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
//   //   if (image == null) return null;
//   //   setState(() {
//   //     _loading = true;
//   //     _image = File(image.path);
//   //     print(_image);
//   //   });
//   //   classifyImage(File(image.path));
//   // }

//   classifyImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 2,
//       threshold: 0.5,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );

//     setState(() {
//       _loading = false;
//       _outputs = output;
//       print(_outputs);
//     });
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/models/model.tflite",
//       labels: "assets/models/labels.txt",
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }
// }
