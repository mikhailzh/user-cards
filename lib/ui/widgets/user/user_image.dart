import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String href;
  final WidgetBuilder? loadingBuilder;

  const UserImage({
    Key? key,
    required this.href,
    this.loadingBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      href,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress != null ? _loading(context) : child,
    );
  }

  Widget _loading(BuildContext context) =>
      loadingBuilder?.call(context) ??
      const Center(
        child: CircularProgressIndicator(),
      );
}
