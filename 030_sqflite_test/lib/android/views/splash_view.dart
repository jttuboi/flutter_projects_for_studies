import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  //final controller = AuthController();

  @override
  void initState() {
    super.initState();
    // controller.authenticate().then((result) {
    //   if (result) {
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (context) => HomeView(),
    //       ),
    //     );
    //   } else {
    //     //
    //   }
    // }).catchError((e, s) {
    //   log('', error: e, stackTrace: s);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          Icon(Icons.fingerprint, size: 72, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 20),
          Text("Meus Contatos", style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.secondary)),
        ],
      ),
    );
  }
}
