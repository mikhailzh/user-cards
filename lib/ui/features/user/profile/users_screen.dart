import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:user_cards/common/constants/paddings.dart';
import 'package:user_cards/common/constants/strings.dart';
import 'package:user_cards/common/constants/type.dart';
import 'package:user_cards/domain/models/report.dart';
import 'package:user_cards/ui/features/app_screen.dart';
import 'package:user_cards/ui/features/user/profile/users_view_model.dart';
import 'package:user_cards/ui/widgets/texts/app_text.dart';
import 'package:user_cards/ui/widgets/texts/emoji_and_count_view.dart';
import 'package:user_cards/ui/widgets/texts/emoji_text.dart';
import 'package:user_cards/ui/widgets/tiktok_scroller.dart';
import 'package:user_cards/ui/widgets/user/user_view.dart';

class UsersScreen extends AppScreen<UsersViewModel> {
  UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (ctx) => viewModel.users.isNotEmpty ? _content : const SizedBox(),
      ),
    );
  }

  Widget get _content => Stack(
        children: [
          TikTokScroller(
            contentSize: viewModel.users.length,
            currentPage: viewModel.currentPage,
            onPageChanged: viewModel.onPageChanged,
            builder: (context, index, scrollProgress, type) => Observer(
              builder: (ctx) => UserView(
                onLikeClick: viewModel.like,
                user: viewModel.users[index],
                location: viewModel.location,
                startVoice: viewModel.startAudio,
                openReport: (_) => openReport(context),
                musicProgress: viewModel.progress,
                scrollProgress: scrollProgress,
                direction: type == PageType.upper ? 1 : -1,
              ),
            ),
          ),
          _buttons,
        ],
      );

  Widget get _buttons => SafeArea(
        child: Column(
          children: [
            Paddings.seven.spacer(),
            _boostAndMessage,
            Paddings.normal.expanded(),
            _verdictButtons,
            SizedBox(height: 102),
          ],
        ),
      );

  Widget get _verdictButtons => Row(
        children: [
          Paddings.normal.expanded(),
          Column(
            children: [
              _instantMatch,
              Paddings.ten.spacer(),
              _superLike,
              Paddings.ten.spacer(),
              _sendMessage,
            ],
          ),
          Paddings.twenty.spacer(),
        ],
      );

  Widget get _boostAndMessage => Row(
        children: [
          Paddings.normal.expanded(),
          _boost,
          Paddings.extraSmall.spacer(),
          _message,
          Paddings.secondaryNormal.spacer(),
        ],
      );

  Widget get _boost => EmojiAndCountView(
        emoji: Strings.users.boost(),
      );

  Widget get _message => EmojiAndCountView(
        emoji: Strings.users.hasMessages(),
        count: 3, // todo add logic
      );

  void openReport(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      title: _sheetText(Strings.users.report()),
      androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: _sheetText(Strings.users.spam()),
          onPressed: (ctx) => cancelSheetAndSendReport(ctx, Report.spam),
        ),
        BottomSheetAction(
          title: _sheetText(Strings.users.fake()),
          onPressed: (ctx) => cancelSheetAndSendReport(ctx, Report.fake),
        ),
      ],
      cancelAction: CancelAction(
        title: _sheetText(Strings.users.cancel(), CupertinoColors.destructiveRed),
      ), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  void cancelSheetAndSendReport(BuildContext context, Report report) {
    Navigator.of(context).pop();
    viewModel.sendReport(report);
  }

  Widget _sheetText(String text, [Color color = CupertinoColors.activeBlue]) => AppText(
        text: text,
        style: AppTextStyle.bodyText1,
        color: color,
      );

  Widget get _instantMatch => _verdictButton(
        emoji: Strings.users.instantMatch(),
        onTap: viewModel.superLike,
      ); // todo add logic instant match

  Widget get _superLike => _verdictButton(
        emoji: Strings.users.superLike(),
        onTap: viewModel.superLike,
      );

  Widget get _sendMessage => _verdictButton(
        emoji: Strings.users.sendMessage(),
        onTap: viewModel.superLike,
      ); // todo add logic send message

  Widget _verdictButton({required String emoji, required VoidCallback onTap}) => ScaleTap(
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(Paddings.seven.value),
          child: EmojiText(emoji: emoji),
        ),
        onPressed: onTap,
        enableFeedback: false,
      );
}
