import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'button_style.dart';

SizedBox getTextButton(String text, double width, double height,
    double fontSize, Color color, route, args, context) {
  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton(
      style: getButtonStyle(200, 60, 20.0, color),
      onPressed: () {
        Navigator.pushNamed(
          context,
          route,
          arguments: args,
        );
      },
      child: getText(text, fontSize, Alignment.center),
    ),
  );
}
