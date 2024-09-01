import 'package:follow_my_tracks/domain/track.dart';

class DeletedTrack {
  DeletedTrack(this.index, this.track);

  DeletedTrack.empty()
      : index = -1,
        track = const Track.empty();

  final int index;
  final Track track;

  bool get hasTrack => index != -1;

  bool get hasNotTrack => index == -1;

  @override
  String toString() {
    return 'DeleteTrack($index, $track)';
  }
}
