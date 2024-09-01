import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/domain/marker_map_cubit.dart';
import 'package:follow_my_tracks/domain/track.dart';
import 'package:follow_my_tracks/domain/track_cubit.dart';
import 'package:follow_my_tracks/presentation/track_page.dart';

class EditTrackPage extends StatelessWidget {
  const EditTrackPage(this.track, {Key? key}) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return TrackPage(
      title: 'Edit track',
      trackName: track.name,
      onInit: () {
        context.read<TrackCubit>().initWithLoadTrack(track);
        context.read<MarkersCubit>().initWithLoadTrack(track);
      },
    );
  }
}
