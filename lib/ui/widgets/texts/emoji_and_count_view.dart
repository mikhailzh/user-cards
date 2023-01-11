import 'package:flutter/material.dart';
import 'package:user_cards/common/constants/paddings.dart';
import 'package:user_cards/common/constants/type.dart';
import 'package:user_cards/ui/widgets/texts/app_text.dart';
import 'package:user_cards/ui/widgets/texts/emoji_text.dart';

class EmojiAndCountView extends StatelessWidget {
  final String emoji;
  final int? count;

  const EmojiAndCountView({
    Key? key,
    required this.emoji,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        _emoji,
        _count,
      ],
    );
  }

  Widget get _emoji => Padding(
        padding: EdgeInsets.only(
          top: Paddings.extraSmall.value,
          right: Paddings.tiny.value,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          padding: EdgeInsets.all(Paddings.five.value),
          child: EmojiText(
            emoji: emoji,
          ),
        ),
      );

  Widget get _count => Opacity(
        opacity: count == null ? 0 : 1,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          padding: EdgeInsets.all(Paddings.extraTiny.value),
          child: AppText(
            text: count != null && count! > 9 ? "9+" : "${count ?? 0}",
            style: AppTextStyle.caption,
          ),
        ),
      );
}
