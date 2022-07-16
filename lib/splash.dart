import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:justotest/constants.dart';
import 'package:justotest/home.dart';
import 'package:justotest/models.dart';
import 'package:justotest/services.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late RandomUser user;
  Future<Timer> loadData() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.fetchData();
    return Timer(
        const Duration(seconds: 1, milliseconds: 618, microseconds: 0339),
        onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushAndRemoveUntil(context,
        CupertinoPageRoute<Widget>(builder: (BuildContext context) {
      return const Home();
    }), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: lightColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              CupertinoIcons.check_mark_circled,
              size: 111,
              color: CupertinoColors.white,
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              "justo",
              style: justoH4Green,
            ),
          ],
        ),
      ),
    );
  }
}
