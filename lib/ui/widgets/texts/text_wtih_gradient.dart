import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_cards/common/constants/paddings.dart';
import 'package:user_cards/common/constants/radii.dart';
import 'package:user_cards/common/constants/type.dart';
import 'package:user_cards/ui/widgets/texts/app_text.dart';
import 'package:user_cards/ui/widgets/texts/emoji_text.dart';

class TextWithGradient extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final AppTextStyle style;
  final Gradient gradient;
  final EdgeInsets? padding;
  final bool isEmoji;

  const TextWithGradient({
    Key? key,
    required this.text,
    required this.style,
    required this.gradient,
    this.color = Colors.white,
    this.textAlign,
    this.padding,
    this.isEmoji = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.all(Radius.circular(Radii.extraLarge)),
      ),
      padding: padding ?? EdgeInsets.all(Paddings.tiny.value),
      child: isEmoji ? EmojiText(emoji: text, style: style,): AppText(
        text: text,
        style: style,
        color: color,
        textAlign: textAlign,
      ),
    );
  }
}
