import 'package:flutter/material.dart';
import 'package:user_cards/ui/widgets/page_view_indicator.dart';
import 'package:user_cards/ui/widgets/user/user_image.dart';

const _indicatorPadding = EdgeInsets.only(
  bottom: 92,
  left: 42,
  right: 42,
);

class UserImages extends StatefulWidget {
  final List<String> images;
  final WidgetBuilder? loadingBuilder;

  const UserImages({
    Key? key,
    required this.images,
    this.loadingBuilder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserImagesState();
}

class _UserImagesState extends State<UserImages> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        _pageView(),
        _indicatorWithContainer(),
      ],
    );
  }

  Widget _pageView() {
    return SizedBox(
      height: double.infinity,
      child: PageView.builder(
        itemCount: widget.images.length,
        controller: _pageController,
        itemBuilder: (context, index) => UserImage(
          href: widget.images[index],
          loadingBuilder: widget.loadingBuilder,
        ),
        onPageChanged: (index) => _currentPageNotifier.value = index,
      ),
    );
  }

  Widget _indicatorWithContainer() {
    return SafeArea(
      child: Padding(
        padding: _indicatorPadding,
        child: LayoutBuilder(
          builder: (context, constraints) => _indicator(constraints),
        ),
      ),
    );
  }

  Widget _indicator(BoxConstraints constraints) {
    return PageViewIndicator(
      itemCount: widget.images.length,
      currentPageNotifier: _currentPageNotifier,
      width: constraints.maxWidth,
    );
  }
}
