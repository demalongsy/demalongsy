import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/pages/search.dart';
import 'package:flutter/material.dart';

class PostTrending extends StatefulWidget {
  const PostTrending({super.key});

  @override
  State<PostTrending> createState() => _PostTrendingState();
}

class _PostTrendingState extends State<PostTrending> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  void initState() {
    super.initState();
    _calculation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.backgroundWhiteIvory,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: FutureBuilder<String>(
            future: _calculation,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: false)
                          .push(createTransitionRoute(Profile(), 1, 0));
                    },
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Result: ${snapshot.data}'),
                  ),
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ),
      )),
    );
  }
}
