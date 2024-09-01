import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_form/views/bloc/person_form_bloc.dart';
import 'package:person_form/views/pages/camera_page.dart';

class PictureField extends StatelessWidget {
  const PictureField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonFormBloc, PersonFormState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _onChangePicture(context),
          child: ClipOval(
            child: (state.picture == null) ? Image.asset('assets/default_avatar.png') : Image.file(state.picture!, width: 128, height: 128),
          ),
        );
      },
    );
  }

  void _onChangePicture(BuildContext context) async {
    final cameras = await availableCameras();
    final file = await Navigator.pushNamed(context, CameraPage.routeName, arguments: cameras) as File?;
    if (file != null) {
      context.read<PersonFormBloc>().add(PictureChanged(file));
    }
  }
}
