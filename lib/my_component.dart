import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_colors.dart';

class techDivider extends StatelessWidget {
  const techDivider({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.5,
      color: solidColors.dividerColor,
      indent: size.width/6,
      endIndent:  size.width/6,
    );
  }
}