import 'package:flutter/cupertino.dart';
import 'package:justotest/constants.dart';
import 'package:justotest/services.dart';
import 'package:justotest/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Random User',
      theme: CupertinoThemeData(
        primaryColor: primaryColor,
        primaryContrastingColor: primaryColor,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
