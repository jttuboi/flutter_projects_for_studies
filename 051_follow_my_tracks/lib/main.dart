import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/data/directions_repository.dart';
import 'package:follow_my_tracks/data/tracks_repository.dart';
import 'package:follow_my_tracks/domain/maps_cubit.dart';
import 'package:follow_my_tracks/domain/marker_map_cubit.dart';
import 'package:follow_my_tracks/domain/track.dart';
import 'package:follow_my_tracks/domain/track_cubit.dart';
import 'package:follow_my_tracks/domain/tracks_cubit.dart';
import 'package:follow_my_tracks/presentation/add_track_page.dart';
import 'package:follow_my_tracks/presentation/edit_track_page.dart';
import 'package:follow_my_tracks/presentation/map_page.dart';
import 'package:follow_my_tracks/presentation/routes.dart';
import 'package:follow_my_tracks/presentation/tracks_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final repository = TracksRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case mapRoute:
            return MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => MapsCubit()),
                ],
                child: const MapPage(),
              ),
            );
          case tracksRoute:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TracksCubit(repository),
                child: const TracksPage(),
              ),
            );
          case addTrackRoute:
            return MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => TrackCubit(repository)),
                  BlocProvider(create: (context) => MarkersCubit(DirectionsRepository(dio: Dio()))),
                ],
                child: const AddTrackPage(),
              ),
            );
          case editTrackRoute:
            final trackToEdit = settings.arguments! as Track;
            return MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => TrackCubit(repository)),
                  BlocProvider(create: (context) => MarkersCubit(DirectionsRepository(dio: Dio()))),
                ],
                child: EditTrackPage(trackToEdit),
              ),
            );
        }
        return null;
      },
    );
  }
}
