import 'package:flutter/material.dart';
import 'package:user_cards/common/constants/type.dart';
import 'package:user_cards/ui/extensions/build_context.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final double? width;
  final AppTextStyle style;
  final TextOverflow? overflow;
  final bool? softWrap;
  final int? maxLines;

  const AppText({
    Key? key,
    required this.text,
    required this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.maxLines,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = style.textStyle(context.textTheme);
    return SizedBox(
        width: width,
        child: Text(
          text,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          softWrap: softWrap,
          style: color == null ? textStyle : textStyle?.copyWith(color: color),
        ));
  }
}
