import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gen/assets.gen.dart';
import 'models/fake_data.dart';
import 'my_colors.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.5,
      color: SolidColors.dividerColor,
      indent: size.width / 6,
      endIndent: size.width / 6,
    );
  }
}

class MainTags extends StatelessWidget {
  MainTags({
    Key? key,
    required this.textTheme,
    required this.index,
  }) : super(key: key);

  final TextTheme textTheme;
  var index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        gradient: LinearGradient(
            colors: GradiantColors.tags,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            ImageIcon(
              Assets.icons.hashtagicon,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              tagList[index].title,
              style: textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}

 