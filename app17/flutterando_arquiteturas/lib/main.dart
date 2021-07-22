import 'package:flutter/material.dart';
import 'package:flutterando_arquiteturas/mvc/login_page.dart';
import 'package:flutterando_arquiteturas/mvp/login_page.dart';
import 'package:flutterando_arquiteturas/mvvm/login_page.dart';

void main() => runApp(MaterialApp(
      title: 'Architectures',
      debugShowCheckedModeBanner: false,
      home: LoginPageMVVM(),
      //home: LoginPageMVP(),
      //home: LoginPageMVC(),
    ));
