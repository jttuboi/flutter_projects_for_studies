import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/data/tracks_repository.dart';
import 'package:follow_my_tracks/domain/track.dart';

class TracksCubit extends Cubit<TracksState> {
  TracksCubit(this.repository) : super(TracksLoading());

  final TracksRepository repository;

  void refresh() {
    emit(TracksLoading());

    repository.fetchTracks().then((tracksFetched) {
      emit(TracksLoaded(tracksFetched));
    }).onError((error, stackTrace) {
      emit(TracksError(Exception('erro no banco de dados - $error')));
    });
  }

  void deleteTrack(Track trackToDelete) {
    repository.deleteTrack(trackToDelete);

    repository.fetchTracks().then((tracksFetched) {
      emit(TracksLoaded(tracksFetched));
    }).onError((error, stackTrace) {
      emit(TracksError(Exception('erro no banco de dados - $error')));
    });
  }
}

abstract class TracksState {}

class TracksLoaded implements TracksState {
  TracksLoaded(this.tracks);
  final List<Track> tracks;
}

class TracksLoading implements TracksState {
  TracksLoading();
}

class TracksError implements TracksState {
  TracksError(this.exception);
  final Exception exception;
}
