import 'dart:io';

import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/search_similar/widget_similar.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
//import 'package:url_launcher/url_launcher.dart';

import 'package:demalongsy/custom/widget/font.dart';

import 'package:tflite/tflite.dart';

import '../suggest/suggest_style.dart';

class SimilarStylePage extends StatefulWidget {
  final File? image;
  final bool isformPost;

  const SimilarStylePage({Key? key, this.image, required this.isformPost})
      : super(key: key);
  @override
  _SimilarStylePageState createState() => _SimilarStylePageState();
}

class _SimilarStylePageState extends State<SimilarStylePage> {
  List? _outputs;
  File? _image;
  bool _loading = false;

  // Image

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

    classifyImage(widget.image!);
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model2/model.tflite",
      labels: "assets/model2/labels.txt",
    );
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
                          Navigator.of(context).pop();
                        }),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Poppins(
                        text: "Similar Items",
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
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                      height: 200,
                      width: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          widget.image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),

                        // ClipRRect(
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Poppins(
                    text: "Your suggest items list",
                    size: 12,
                    color: C.textDefault,
                    fontWeight: FW.bold,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                _loading
                    ? Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : _outputs != null && _outputs!.length > 0
                        ? WidgetSimilar(
                            color:
                                _outputs![0]['label'].toString().substring(2),
                            image: widget.image!,
                          )
                        : Center(
                            child: Poppins(
                              text: "There is no data in the system.",
                              size: 14,
                              color: C.textDefault,
                              fontWeight: FW.bold,
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }

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
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
