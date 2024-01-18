import 'package:flutter/material.dart';

const logoColor = Color(0xFF2596BE);
const primaryColor = Color(0xFF004B8D);
const secondaryColor = Color(0xFF004B8D);
const backgroundColor = Color(0xFF004B8D);

TextStyle headline1Style = const TextStyle(
  fontSize: 30,
  color: logoColor
);

TextStyle headline2Style = const TextStyle(
    fontSize: 25,
    color: logoColor
);

TextStyle headline3Style = const TextStyle(
    fontSize: 20,
    color: logoColor
);

TextStyle contentStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black38
);

TextStyle contentWhiteStyle = const TextStyle(
    fontSize: 16,
    color: Colors.white
);

TextStyle contentWhiteBoldStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white
);


TextStyle blueWhiteStyle = const TextStyle(
    fontSize: 16,
    color: Colors.blue
);

TextStyle headline1WhiteStyle = const TextStyle(
    fontSize: 30,
    color: Colors.white
);

TextStyle headline3WhiteStyle = const TextStyle(
    fontSize: 20,
    color: Colors.white
);

TextStyle black16BoldStyle = const TextStyle(
    color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900
);

TextStyle white16BoldStyle = const TextStyle(
    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1
);

TextStyle white12BoldStyle = const TextStyle(
    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1
);

ButtonStyle buttonStyle = const ButtonStyle(
 padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10),), // MaterialStatePropertyAll(EdgeInsets.all(20)),
  minimumSize: MaterialStatePropertyAll(Size(100, 50)),
);

ButtonStyle buttonBlueStyle =  ButtonStyle(
 backgroundColor:  MaterialStateProperty.all<Color>(logoColor),
 textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(color: Colors.white)),
 padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10),), // MaterialStatePropertyAll(EdgeInsets.all(20)),
 minimumSize: const MaterialStatePropertyAll(Size(100, 50)),
);

ButtonStyle buttonGreen16Style =  ButtonStyle(
 backgroundColor:  MaterialStateProperty.all<Color>(logoColor),
 textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(color: Colors.white)),
 padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10),), // MaterialStatePropertyAll(EdgeInsets.all(20)),
 minimumSize: const MaterialStatePropertyAll(Size(100, 50)),
);

// White text font style
TextStyle buttonWhiteTextStyle24 = const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);