import 'package:flutter/material.dart';

class GeneralTableRow {
  static TableRow row(
          {TextAlign? textAlign,
          Decoration? decoration,
          FontWeight? fontWeight,
          String? fontFamily = "times",
          double? fontSizeOne = 8.0,
          double? fontSizTwo = 8.0,
          double? fontSizeThree = 8.0,
          double? fontSizeFour = 8.0,
          String columnOne = "",
          String columnTwo = "",
          String columnThree = "",
          String columnFour = ""}) =>
      TableRow(
        decoration: decoration,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(columnOne,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSizeOne,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(columnTwo,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSizTwo,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(columnThree,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSizeThree,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(columnFour,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSizeFour,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily,
                )),
          ),
        ],
      );
}
