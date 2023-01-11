import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_cards/common/constants/gradient.dart';
import 'package:user_cards/common/constants/image_assets.dart';
import 'package:user_cards/common/constants/paddings.dart';
import 'package:user_cards/ui/widgets/progress_indicator.dart';

class MusicButton extends StatefulWidget {
  final Stream<double?>? progress;
  final VoidCallback onTap;

  const MusicButton({
    Key? key,
    required this.progress,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MusicButtonState();
}

class _MusicButtonState extends State<MusicButton> {

  double? progress;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _startSub();
  }

  @override
  void didUpdateWidget(covariant MusicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) _updateSub();
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
    _sub = widget.progress?.listen((event) {
      setState(() {
        progress = event;
      });
    });
    if (_sub == null) {
      setState(() {
        progress = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = this.progress != null ? ImageAssets.stop : ImageAssets.play;
    final progress = this.progress ?? 1;
    return ScaleTap(
      onPressed: widget.onTap,
      enableFeedback: false,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(6),
        child: _content(image, progress),
      ),
    );
  }

  Widget _content(String image, double progress) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _progressView(progress),
        SvgPicture.asset(
          image,
        ),
      ],
    );
  }

  Widget _progressView(double progress) {
    return GradientProgressIndicator(
      gradient: AppGradient.second,
      progress: progress,
    );
  }
}
