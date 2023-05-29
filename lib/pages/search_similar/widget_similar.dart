import 'dart:io';

import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/models/similar_product.dart';
import 'package:demalongsy/pages/search_similar/widget_similar1.dart';
import 'package:demalongsy/widget/showstyle.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
//import 'package:url_launcher/url_launcher.dart';

import 'package:demalongsy/custom/widget/font.dart';

import 'package:tflite/tflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class WidgetSimilar extends StatefulWidget {
  final String color;
  final File? image;
  const WidgetSimilar({Key? key, required this.color, this.image})
      : super(key: key);

  @override
  State<WidgetSimilar> createState() => _WidgetSimilarState();
}

class _WidgetSimilarState extends State<WidgetSimilar> {
  bool isLoading = true;
  ViewSimilar? data;
  List? _outputs;
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

    classifyImage(widget.image!);
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/model.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  // _getData() async {
  //   var url = '${Url.baseurl}/similarStyle/${widget.col}';

  //   var response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     data = viewSimilarFromJson(response.body);

  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Image.asset(
              "assets/images/loading.gif",
              height: 48,
              width: 48,
            ),
          )
        : _loading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : _outputs != null && _outputs!.length > 0
                ? WidgetSimilar1(
                    category: _outputs![0]['label'].toString().substring(2),
                    color: widget.color,
                  )
                : Center(
                    child: Poppins(
                      text: "There is no data in the system.",
                      size: 14,
                      color: C.textDefault,
                      fontWeight: FW.bold,
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
      isLoading = false;
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
