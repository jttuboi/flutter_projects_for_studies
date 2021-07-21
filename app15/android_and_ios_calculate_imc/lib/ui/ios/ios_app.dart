import 'package:android_and_ios_calculate_imc/ui/ios/pages/home_page.dart';
import 'package:flutter/cupertino.dart';

class IosApp extends StatelessWidget {
  const IosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'IMC',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
