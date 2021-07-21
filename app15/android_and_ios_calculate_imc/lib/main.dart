import 'dart:io' show Platform;
import 'package:android_and_ios_calculate_imc/ui/android/android_app.dart';
import 'package:android_and_ios_calculate_imc/ui/ios/ios_app.dart';
import 'package:flutter/material.dart';

void main() => Platform.isIOS ? runApp(IosApp()) : runApp(AndroidApp());
