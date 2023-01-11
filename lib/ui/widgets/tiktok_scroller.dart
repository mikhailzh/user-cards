import 'package:flutter/cupertino.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class TikTokScroller extends StatefulWidget {
  final int contentSize;
  final IndexedWidgetWithAnimationBuilder builder;
  final Function(int) onPageChanged;
  final int currentPage;

  const TikTokScroller({
    Key? key,
    required this.contentSize,
    required this.builder,
    required this.currentPage,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TikTokScrollerState();
}

class _TikTokScrollerState extends State<TikTokScroller> {
  final controller = Controller();

  @override
  void initState() {
    super.initState();
    controller.jumpToPosition(widget.currentPage);
    controller.addListener((event) {
      // print('controller.addListener');
      final page = controller.getScrollPosition();
      if (page != widget.currentPage) {
        widget.onPageChanged(page);
      }
    });
  }

  @override
  void didUpdateWidget(covariant TikTokScroller oldWidget) {
    final page = controller.getScrollPosition();
    if (oldWidget.currentPage != widget.currentPage && page != widget.currentPage) {
      controller.animateToPosition(widget.currentPage);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TikTokStyleFullPageScroller(
      contentSize: widget.contentSize,
      builder: widget.builder,
      controller: controller,
    );
  }
}
