import 'package:flutter/material.dart';

class Styles {
  static const _font = 'inter';

  // regular
  static TextStyle regular(
    double size,
    Color color, {
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: _font,
      color: color,
      height: 1.25,
      fontStyle: fontStyle,
      decoration: textDecoration,
      fontSize: size,
    );
  }

  // medium
  static TextStyle medium(
    double size,
    Color color, {
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: _font,
      color: color,
      height: 1.25,
      decoration: textDecoration,
      fontSize: size,
    );
  }

  // semibold
  static TextStyle semibold(
    double size,
    Color color, {
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: _font,
      color: color,
      height: 1.25,
      decoration: textDecoration,
      fontSize: size,
    );
  }
}
