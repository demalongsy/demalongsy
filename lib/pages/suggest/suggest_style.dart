import 'dart:io';
import 'package:demalongsy/pages/suggest/widget_suggest.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:tflite/tflite.dart';

class SuggestStylePage extends StatefulWidget {
  final File? image;
  const SuggestStylePage({Key? key, this.image}) : super(key: key);
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

    classifyImage(widget.image!);
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/model.tflite",
      labels: "assets/models/labels.txt",
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
                          text: "Suggest Items",
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
            body: _loading
                ? Center(
                    child: Image.asset(
                      "assets/images/loading.gif",
                      height: 48,
                      width: 48,
                    ),
                  )
                : _outputs != null && _outputs!.length > 0
                    ? WidgetSuggest(
                        category: _outputs![0]['label'].toString().substring(2))
                    : Center(child: Text('Not Found'))),
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

    print(_outputs);
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
