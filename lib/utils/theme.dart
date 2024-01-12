import 'package:flutter/material.dart';

const logoColor = Color(0xFF2596BE);
const primaryColor = Color(0xFF004B8D);
const secondaryColor = Color(0xFF004B8D);
const backgroundColor = Color(0xFF004B8D);


TextStyle headline1Style = const TextStyle(
  fontSize: 30,
  color: logoColor
);

ButtonStyle buttonStyle = const ButtonStyle(
 padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10),), // MaterialStatePropertyAll(EdgeInsets.all(20)),
  minimumSize: MaterialStatePropertyAll(Size(100, 50)),
);