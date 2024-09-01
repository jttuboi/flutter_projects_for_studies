import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/domain/track_cubit.dart';
import 'package:follow_my_tracks/presentation/track_page.dart';

class AddTrackPage extends StatelessWidget {
  const AddTrackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TrackPage(
      title: 'Add track',
      onInit: () => context.read<TrackCubit>().initNewTrack(),
    );
  }
}
