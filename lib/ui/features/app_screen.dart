import 'package:flutter/material.dart';
import 'package:user_cards/common/utils/keyboard_utils.dart';
import 'package:user_cards/di/di.dart';
import 'package:user_cards/ui/features/app_view_model.dart';

abstract class AppScreen<T extends AppViewModel> extends StatefulWidget {
  final T viewModel;

  @override
  State<StatefulWidget> createState() => _AppScreenState();

  AppScreen({
    Key? key,
    T? viewModel,
  })  : viewModel = viewModel ?? getIt(),
        super(key: key);

  Widget build(BuildContext context);

  dispose() {}
}

class _AppScreenState<T extends AppViewModel> extends State<AppScreen<T>> {
  T get _viewModel => widget.viewModel;

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose();
    _viewModel.dispose();
  }
}
