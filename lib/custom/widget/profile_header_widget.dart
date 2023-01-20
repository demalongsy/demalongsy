import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';

Widget profileHeaderWidget(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.only(left: 38, right: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xff74EDED),
                backgroundImage:
                    NetworkImage("https://placeimg.com/640/480/people"),
              ),
              const SizedBox(
                width: 28,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Poppins(
                      text: "K. Payongdech",
                      size: 18,
                      color: C.dark1,
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 10,
                  ),
                  const Poppins(
                      text: "@Dekdee2023_",
                      size: 12,
                      color: C.dark1,
                      fontWeight: FontWeight.w400),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Poppins(
                          text: "128 ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FontWeight.w700),
                      Poppins(
                          text: "Posts",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        width: 12,
                      ),
                      Poppins(
                          text: "12K ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FontWeight.w700),
                      Poppins(
                          text: "Likes ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Poppins(
              text: "Fantastic to start to use application!",
              size: 14,
              color: C.dark3,
              fontWeight: FontWeight.w400),
          const SizedBox(
            height: 12,
          ),
          actions(context),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    ),
  );
}

Widget actions(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: C.secondaryDefault, // Background color
              onPrimary: C.secondaryPressed, // Text Color (Foreground color)
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              shadowColor: Colors.transparent),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Poppins(
                text: "Edit Profile",
                size: 12,
                color: C.dark1,
                fontWeight: FontWeight.w700),
          ),
          onPressed: () {},
        ),
      ),
    ],
  );
}
