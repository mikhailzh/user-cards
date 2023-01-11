import 'package:flutter/material.dart';
import 'package:user_cards/common/constants/durations.dart';

const _defaultProgressColor = Colors.white;
const _defaultBackgroundColor = Color.fromARGB(112, 255, 255, 255);
const double _height = 1;
const double _defaultHorizontalPadding = 10;

class PageViewIndicator extends StatefulWidget {
  final ValueNotifier<int> currentPageNotifier;

  final double width;

  final int itemCount;

  final Duration duration;

  final Color progressColor;

  final Color backgroundColor;

  final double horizontalPadding;

  const PageViewIndicator({
    Key? key,
    required this.currentPageNotifier,
    required this.width,
    required this.itemCount,
    this.progressColor = _defaultProgressColor,
    this.backgroundColor = _defaultBackgroundColor,
    this.horizontalPadding = _defaultHorizontalPadding,
    this.duration = AnimationDuration.short,
  }) : super(key: key);

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeTween;
  late var width = widget.width;
  late double previousWidth = 0;
  late var stepWidth = width / itemCount;
  late var itemCount = widget.itemCount;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animationController.addListener(() => setState(() {}));

    _onCurrentPageNotifierValueChanged();
    widget.currentPageNotifier.addListener(_onCurrentPageNotifierValueChanged);

    super.initState();
  }

  @override
  void dispose() {
    widget.currentPageNotifier.removeListener(_onCurrentPageNotifierValueChanged);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: CustomPaint(
        painter: ProgressPainter(
          _sizeTween,
          _height,
          widget.width,
          widget.progressColor,
          widget.backgroundColor,
          itemCount,
          widget.horizontalPadding,
        ),
      ),
    );
  }

  void _onCurrentPageNotifierValueChanged() {
    _readCurrentPageNotifierValue();
    _resetAnimation();
  }

  void _readCurrentPageNotifierValue() {
    final nextWidth = stepWidth * (widget.currentPageNotifier.value + 1);
    _sizeTween = Tween(begin: previousWidth, end: nextWidth).animate(_animationController);
    previousWidth = nextWidth;
  }

  void _resetAnimation() {
    _animationController.reset();
    _animationController.forward();
  }
}

class ProgressPainter extends CustomPainter {
  late Paint bgPaint;
  late Paint progressPaint;
  final Animation<double> value;
  final double height;
  final double width;
  final Color progressColor;
  final Color backgroundColor;
  final int itemCount;
  final double horizontalPadding;

  ProgressPainter(
    this.value,
    this.height,
    this.width,
    this.progressColor,
    this.backgroundColor,
    this.itemCount,
    this.horizontalPadding,
  ) {
    bgPaint = Paint()..color = backgroundColor;
    progressPaint = Paint()..color = progressColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final progressRects = addPadding(Offset(0.0, 0.0) & Size(value.value, height));
    final bgRects = addPadding(Offset(0.0, 0.0) & Size(width, height));
    for (final bgRect in bgRects) {
      canvas.drawRect(bgRect, bgPaint);
    }
    for (final progressRect in progressRects) {
      canvas.drawRect(progressRect, progressPaint);
    }
  }

  List<Rect> addPadding(Rect rect) {
    final step = width / itemCount;
    final padding = horizontalPadding / 2;
    final result = <Rect>[];
    double currWidth = 0;
    while (currWidth < width && currWidth + padding < rect.right - padding) {
      final endCurrRect = currWidth + step;
      if (endCurrRect < rect.width + rect.left) {
        result.add(Rect.fromLTRB(currWidth + padding, rect.top, endCurrRect - padding, rect.bottom));
      } else {
        result.add(Rect.fromLTRB(currWidth + padding, rect.top, rect.right - padding, rect.bottom));
      }
      currWidth = endCurrRect;
    }
    return result;
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) {
    return true;
  }
}
