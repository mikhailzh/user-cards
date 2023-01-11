import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:user_cards/common/constants/gradient.dart';
import 'package:user_cards/common/constants/image_assets.dart';
import 'package:user_cards/common/constants/paddings.dart';
import 'package:user_cards/common/constants/type.dart';
import 'package:user_cards/domain/models/user.dart';
import 'package:user_cards/ui/extensions/language_ext.dart';
import 'package:user_cards/ui/extensions/location_ext.dart';
import 'package:user_cards/ui/extensions/user_ext.dart';
import 'package:user_cards/ui/extensions/user_goal_ext.dart';
import 'package:user_cards/ui/extensions/verdict_ext.dart';
import 'package:user_cards/ui/widgets/music_button.dart';
import 'package:user_cards/ui/widgets/texts/app_text.dart';
import 'package:user_cards/ui/widgets/texts/emoji_text.dart';
import 'package:user_cards/ui/widgets/texts/text_wtih_gradient.dart';
import 'package:user_cards/ui/widgets/user/hobbies_view.dart';
import 'package:user_cards/ui/widgets/user/user_images.dart';

final _onlyEmojiPadding = EdgeInsets.all(Paddings.tiny.value);
const _statusEmojiPadding = EdgeInsets.only(bottom: 96);

class UserView extends StatefulWidget {
  final User user;
  final LocationData? location;
  final Function(String, bool isMusic) startVoice;
  final Function(User) openReport;
  final Stream<double?>? musicProgress;
  final Stream<double>? scrollProgress;
  final int direction;
  final VoidCallback onLikeClick;

  const UserView({
    Key? key,
    required this.user,
    required this.startVoice,
    required this.openReport,
    required this.location,
    required this.musicProgress,
    required this.scrollProgress,
    required this.direction,
    required this.onLikeClick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  User get user => widget.user;

  LocationData? get location => widget.location;

  Function(String, bool isMusic) get startVoice => widget.startVoice;

  Function(User) get openReport => widget.openReport;

  Stream<double?>? get musicProgress => widget.musicProgress;

  Stream<double>? get scrollProgress => widget.scrollProgress;

  int get direction => widget.direction;

  double opacityEmoji = 0;

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _startSub();
  }

  @override
  void didUpdateWidget(covariant UserView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (scrollProgress != oldWidget.scrollProgress) _updateSub();
  }

  @override
  void dispose() {
    _cancelSub();
    super.dispose();
  }

  void _updateSub() {
    _cancelSub();
    _startSub();
  }

  void _cancelSub() {
    _sub?.cancel();
    _sub = null;
  }

  void _startSub() {
    _sub = scrollProgress?.listen((event) {
      final normalProgress = direction == 1 ? 1 - event : event * direction;
      if (normalProgress > 0) {
        setState(() {
          opacityEmoji = min(1, 2 * normalProgress);
        });
      } else {
        setState(() {
          opacityEmoji = 0;
        });
      }
    });
    if (_sub == null) {
      setState(() {
        opacityEmoji = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: widget.onLikeClick,
      child: Stack(
        children: [
          UserImages(
            key: ValueKey(user.id),
            images: user.images,
          ),
          _userInfo,
          _emojiStatusContainer,
        ],
      ),
    );
  }

  Widget get _emojiStatusContainer => Opacity(
        opacity: opacityEmoji,
        child: SafeArea(
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: _statusEmojiPadding,
              child: _emojiStatus,
            ),
          ),
        ),
      );

  Widget get _emojiStatus => Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(Paddings.secondaryNormal.value),
        child: EmojiText(
          emoji: direction == 1 ? "🔄" : user.verdict?.text ?? "💔",
          style: AppTextStyle.headline3,
        ),
      );

  Widget get _userInfo => SafeArea(
        child: Column(
          children: [
            Paddings.extraSmall.spacer(),
            _voiceGoalAndLanguage,
            Paddings.twenty.spacer(),
            _nameAndReport,
            _locationContainer,
            Paddings.normal.expanded(),
            _musicAndHobbies,
            Paddings.secondaryNormal.spacer(),
          ],
        ),
      );

  Widget get _voiceGoalAndLanguage => Row(
        children: [
          Paddings.ten.spacer(),
          Paddings.normal.spacer(),
          _voice,
          Paddings.normal.spacer(),
          _goal,
          Paddings.ten.spacer(),
          _language,
        ],
      );

  Widget get _nameAndReport => Row(
        children: [
          Paddings.normal.spacer(),
          _nameAndAge,
          Paddings.normal.expanded(),
          _report,
          Paddings.normal.spacer(),
        ],
      );

  Widget get _locationContainer => Row(
        children: [
          Paddings.normal.spacer(),
          _location,
        ],
      );

  Widget get _musicAndHobbies => Row(
        children: [
          Paddings.large.spacer(),
          _music,
          Paddings.normal.spacer(),
          _hobbies,
        ],
      );

  Widget get _voice => ScaleTap(
        child: SvgPicture.asset(ImageAssets.voice),
        onPressed: () => startVoice(user.audioMessage, false),
        enableFeedback: false,
      );

  Widget get _report => ScaleTap(
        child: SvgPicture.asset(ImageAssets.report),
        onPressed: () => openReport(user),
        enableFeedback: false,
      );

  Widget get _goal => TextWithGradient(
        text: user.goal.text,
        style: AppTextStyle.bodyText2,
        gradient: AppGradient.main,
      );

  Widget get _language => TextWithGradient(
        text: user.language.text,
        style: AppTextStyle.bodyText2,
        textAlign: TextAlign.right,
        padding: _onlyEmojiPadding,
        gradient: AppGradient.main,
        isEmoji: true,
      );

  Widget get _nameAndAge => AppText(
        text: "${user.name}, ${user.age}",
        style: AppTextStyle.headline3,
        color: Colors.white,
      );

  Widget get _location => AppText(
        text: user.location.textWithDistance(location),
        style: AppTextStyle.subtitle1,
        color: Colors.white,
      );

  Widget get _hobbies => HobbiesView(hobbies: user.hobbies);

  Widget get _music => MusicButton(
        progress: musicProgress,
        onTap: () => startVoice(user.music, true),
      );
}
