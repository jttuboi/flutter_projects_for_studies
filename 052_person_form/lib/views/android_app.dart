import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:person_form/models/models/person.dart';
import 'package:person_form/models/services/api_service.dart';
import 'package:person_form/views/pages/camera_page.dart';
import 'package:person_form/views/pages/person_form_page.dart';
import 'package:person_form/views/pages/persons_page.dart';

class AndroidApp extends StatelessWidget {
  AndroidApp({Key? key}) : super(key: key);

  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case PersonsPage.routeName:
            return PersonsPage.route(apiService: apiService);
          case PersonFormPage.routeName:
            final person = (settings.arguments == null) ? null : settings.arguments as Person;
            return PersonFormPage.route(person, apiService: apiService);
          case CameraPage.routeName:
            final cameras = (settings.arguments == null) ? null : settings.arguments as List<CameraDescription>;
            return CameraPage.route(cameras);
        }
      },
    );
  }
}
