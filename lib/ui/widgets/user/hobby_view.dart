import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:user_cards/common/constants/gradient.dart';
import 'package:user_cards/common/constants/paddings.dart';
import 'package:user_cards/common/constants/radii.dart';
import 'package:user_cards/common/constants/shadows.dart';
import 'package:user_cards/common/constants/type.dart';
import 'package:user_cards/domain/models/hobby.dart';
import 'package:user_cards/ui/extensions/hobby_ext.dart';
import 'package:user_cards/ui/widgets/texts/app_text.dart';
import 'package:user_cards/ui/widgets/texts/emoji_text.dart';

const _defaultBorderColor = Color(0xffE5E5E5);
final _textPadding = EdgeInsets.all(Paddings.tiny.value,);

class HobbyView extends StatelessWidget {
  final Hobby hobby;

  const HobbyView({
    Key? key,
    required this.hobby,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: _border,
        boxShadow: _boxShadow,
        borderRadius: const BorderRadius.all(Radius.circular(Radii.small)),
        color: Colors.white,
      ),
      padding: _textPadding,
      child: _text,
    );
  }

  BoxBorder? get _border {
    if (hobby.isEqual) {
      return const GradientBoxBorder(gradient: AppGradient.second);
    } else {
      return Border.all(color: _defaultBorderColor);
    }
  }

  List<BoxShadow>? get _boxShadow {
    if (hobby.isEqual) {
      return Shadows.elevation4();
    } else {
      return null;
    }
  }

  Widget get _text => EmojiText(
        emoji: hobby.text,
        style: AppTextStyle.subtitle1,
      );
}
