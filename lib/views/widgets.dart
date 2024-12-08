// ignore_for_file: must_be_immutable

import 'package:clan_commerce/themes/global_themes.dart';
import 'package:clan_commerce/utils/size_utils.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    super.key,
    required this.iconData,
    required this.color,
    required this.callBack,
    this.hasShadow = false,
  });
  final IconData iconData;
  final Color color;
  final VoidCallback callBack;
  bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        padding: getPadding(all: 10),
        margin: getMargin(right: 20),
        decoration: BoxDecoration(
            boxShadow: hasShadow
                ? [
                    const BoxShadow(
                        color: GlobalColors.primary,
                        spreadRadius: .6,
                        blurRadius: .6,
                        blurStyle: BlurStyle.outer),
                  ]
                : null,
            shape: BoxShape.circle,
            color: GlobalColors.white),
        child: Icon(iconData, color: color),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  CartButton(
      {super.key,
      required this.action,
      required this.color,
      required this.iconData,
      this.iconColor});
  final VoidCallback action;
  final Color color;
  final IconData iconData;
  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: getPadding(all: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color)),
        child: Icon(
          iconData,
          color: iconColor ?? color,
          size: 14,
        ),
      ),
    );
  }
}
