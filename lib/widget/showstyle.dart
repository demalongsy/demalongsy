import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ShowStyle extends StatefulWidget {
  const ShowStyle({super.key});

  @override
  State<ShowStyle> createState() => _ShowStyleState();
}

class _ShowStyleState extends State<ShowStyle> {
  bool showDatail = false;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 30),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 115,
                    height: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://www.mrporter.com/cms/ycm/resource/blob/882086/e1192ce95010e48bdb44b48344fa6c94/4b29d304-012c-4a5d-82fc-7ef156aced78-data.jpg",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(child: Container()),
                              isSaved
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSaved = false;
                                        });
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          color: C.styletag,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.bookmark,
                                          color: C.dark1,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSaved = true;
                                        });
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          color: C.styletag,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.bookmark_border_rounded,
                                          color: C.dark1,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: C.secondaryDefault,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 8, right: 8, bottom: 3),
                            child: Poppins(
                              text: "Gucci",
                              size: 18,
                              color: C.textDefault,
                              fontWeight: FW.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Poppins(
                            overflow: true,
                            maxLines: 2,
                            text:
                                "Cut to a classic double-breasted silhouette, CHANEL's black wool coat is adorned with CC logo-embossed gold-tone buttons. The piece is finished with a form-fitting belted waist and a buttoned central rear vent.",
                            size: 12,
                            color: C.textDefault,
                            fontWeight: FW.light,
                            letterspacing: 0.64,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: C.styleguide,
                    borderRadius: showDatail
                        ? null
                        : BorderRadius.only(
                            bottomRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Poppins(
                          overflow: true,
                          maxLines: 2,
                          text: "See more product guide",
                          size: 12,
                          color: C.textDefault,
                          fontWeight: FW.regular,
                          letterspacing: 0.64,
                        ),
                      ),
                      Expanded(child: Container()),
                      showDatail
                          ? GestureDetector(
                              onTap: (() {
                                setState(() {
                                  showDatail = false;
                                });
                              }),
                              child: Icon(
                                Icons.arrow_drop_up,
                                color: C.dark1,
                                size: 30,
                              ),
                            )
                          : GestureDetector(
                              onTap: (() {
                                setState(() {
                                  showDatail = true;
                                });
                              }),
                              child: Icon(
                                Icons.arrow_drop_down_outlined,
                                color: C.dark1,
                                size: 30,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              showDatail
                  ? Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Container(
                        color: C.styletag,
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                            width: 115,
                                            height: 115,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              // shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://www.mrporter.com/variants/images/1647597293653447/in/w560_q60.jpg",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: C.secondaryDefault,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Poppins(
                                                      text: "Gucci",
                                                      size: 18,
                                                      color: C.textDefault,
                                                      fontWeight: FW.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Poppins(
                                                    overflow: true,
                                                    maxLines: 2,
                                                    text:
                                                        "Cut to a classic double-breasted silhouette, CHANEL's black wool coat is adorned with CC logo-embossed gold-tone buttons. The piece is finished with a form-fitting belted waist and a buttoned central rear vent.",
                                                    size: 12,
                                                    color: C.textDefault,
                                                    fontWeight: FW.light,
                                                    letterspacing: 0.64,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                            width: 115,
                                            height: 115,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              // shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://www.mrporter.com/variants/images/1647597293600186/in/w560_q60.jpg",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: C.secondaryDefault,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Poppins(
                                                      text: "Gucci",
                                                      size: 18,
                                                      color: C.textDefault,
                                                      fontWeight: FW.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Poppins(
                                                    overflow: true,
                                                    maxLines: 2,
                                                    text:
                                                        "Cut to a classic double-breasted silhouette, CHANEL's black wool coat is adorned with CC logo-embossed gold-tone buttons. The piece is finished with a form-fitting belted waist and a buttoned central rear vent.",
                                                    size: 12,
                                                    color: C.textDefault,
                                                    fontWeight: FW.light,
                                                    letterspacing: 0.64,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                            width: 115,
                                            height: 115,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              // shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  "https://i.etsystatic.com/23846075/c/857/681/18/139/il/3374d5/2784439997/il_340x270.2784439997_dj61.jpg",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: C.secondaryDefault,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Poppins(
                                                      text: "Gucci",
                                                      size: 18,
                                                      color: C.textDefault,
                                                      fontWeight: FW.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Poppins(
                                                    overflow: true,
                                                    maxLines: 2,
                                                    text:
                                                        "Cut to a classic double-breasted silhouette, CHANEL's black wool coat is adorned with CC logo-embossed gold-tone buttons. The piece is finished with a form-fitting belted waist and a buttoned central rear vent.",
                                                    size: 12,
                                                    color: C.textDefault,
                                                    fontWeight: FW.light,
                                                    letterspacing: 0.64,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                            width: 115,
                                            height: 115,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              // shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  "https://cp.lnwfile.com/_/cp/_raw/he/ns/3n.jpg",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: C.secondaryDefault,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Poppins(
                                                      text: "Gucci",
                                                      size: 18,
                                                      color: C.textDefault,
                                                      fontWeight: FW.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Poppins(
                                                    overflow: true,
                                                    maxLines: 2,
                                                    text:
                                                        "Cut to a classic double-breasted silhouette, CHANEL's black wool coat is adorned with CC logo-embossed gold-tone buttons. The piece is finished with a form-fitting belted waist and a buttoned central rear vent.",
                                                    size: 12,
                                                    color: C.textDefault,
                                                    fontWeight: FW.light,
                                                    letterspacing: 0.64,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
