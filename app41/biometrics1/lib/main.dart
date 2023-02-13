import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  _teste();

  runApp(const App());
}

Future<void> _teste() async {
  final auth = LocalAuthentication();
  final canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  final canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();

  print(canAuthenticateWithBiometrics);
  print(canAuthenticate);

  if (!canAuthenticate) return;

  // BiometricType.face
  // BiometricType.fingerprint
  // BiometricType.weak
  // BiometricType.strong
  final availableBiometrics = await auth.getAvailableBiometrics();

  if (availableBiometrics.isNotEmpty) {
    // Some biometrics are enrolled.
  }

  if (availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.face)) {
    // Specific types of biometrics are available.
    // Use checks like this with caution!
  }

  print(availableBiometrics);

  try {
    final didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate to show account balance');

    print(didAuthenticate);

    // // apenas biometria
    // final didAuthenticate = await auth.authenticate(
    //   localizedReason: 'Please authenticate to show account balance',
    //   options: const AuthenticationOptions(biometricOnly: true),
    // );

    // ···
  } on PlatformException {
    // ...
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}
