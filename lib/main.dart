import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:user_cards/common/constants/theme.dart';
import 'package:user_cards/ui/features/user/profile/users_screen.dart';

import 'common/constants/environment.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit(
    env: const String.fromEnvironment(
      AppEnvironment.key,
      defaultValue: Environment.dev,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mobile',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: UsersScreen(),
    );
  }
}
