import 'package:flutter/material.dart';

class GeneralTableRow {

static TableRow row(
          {TextAlign? textAlign,
          Decoration? decoration,
          FontWeight? fontWeight,
          double? fontSize = 8.0,
          String columnOne = "",
          String columnTwo = "",
          String columnThree = ""}) =>
      TableRow(
        decoration: decoration,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(columnOne,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: "Arial",
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(columnTwo,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: "Arial",
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(columnThree,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: "Arial",
                )),
          ),
        ],
      );
}




 