import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  double _ratingScore = 0.5;

  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: C.backgroundWhiteIvory,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: C.backgroundWhiteIvory,
            elevation: 0,
            title: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, right: 24, left: 9),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/images/arrow_back.svg",
                          width: 19,
                          height: 19,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: (() {
                        print(_ratingScore);
                        print(_feedbackController.text);
                      }),
                      child: const Poppins(
                        text: "Send",
                        size: 16,
                        color: C.primaryDefault,
                        fontWeight: FW.bold,
                        letterspacing: 0.64,
                      ),
                    )
                  ]),
            ),
          ),
        ),
        body: Form(
          child: GestureDetector(
            onTap: (() {
              FocusScope.of(context).unfocus();
            }),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Spectral(
                      text: "How was your overall experience",
                      size: 36,
                      color: C.dark1,
                      fontWeight: FW.bold,
                      letterspacing: 0.64,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/hand.svg",
                          width: 21,
                          height: 21,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Poppins(
                            text: "It will help us to serve you better.",
                            size: 14,
                            color: C.textDefault2,
                            fontWeight: FW.regular,
                            letterspacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 0.5,
                      unratedColor: C.disableTextfield.withOpacity(0.5),
                      minRating: 0.5,
                      glow: true,
                      glowColor: C.white,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: C.dark2,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _ratingScore = rating;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Poppins(
                      text: "Do you have any thoughts you’d like to share?",
                      size: 14,
                      color: C.textDefault2,
                      fontWeight: FW.regular,
                      letterspacing: 0.4,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: C.textField,
                          height: MediaQuery.of(context).size.height / 3.9,
                          child: TextFormField(
                            controller: _feedbackController,
                            maxLines: 8,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: C.dark1,
                              fontWeight: FW.regular,
                            ),
                            decoration: const InputDecoration(
                              hintText:
                                  'Fantastic to start to use application!',
                              fillColor: C.textField,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          color: C.textField,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, left: 8, top: 8, bottom: 6),
                                child: SvgPicture.asset(
                                  "assets/images/lineDec.svg",
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          color: C.backgroundWhiteIvory,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/images/feedback.svg",
                                  width: 128,
                                  height: 58,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
