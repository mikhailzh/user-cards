import 'package:flutter/cupertino.dart';
import 'package:user_cards/common/constants/type.dart';
import 'package:user_cards/ui/widgets/texts/app_text.dart';

class EmojiText extends StatelessWidget {
  final String emoji;
  final AppTextStyle style;

  EmojiText({
    Key? key,
    required this.emoji,
    this.style = AppTextStyle.bodyText1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3),
      child: AppText(
        text: emoji,
        style: style,
      ),
    );
  }
}
