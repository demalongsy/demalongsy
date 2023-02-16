import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Account_data {
  final String title;
  final String urlImage;

  const Account_data({
    required this.title,
    required this.urlImage,
  });
}

const Account_list = [
  Account_data(
      title: 'Top',
      urlImage:
          'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
  Account_data(
      title: 'Tosapon',
      urlImage:
          'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
  Account_data(
      title: 'Too fast',
      urlImage:
          'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
];
