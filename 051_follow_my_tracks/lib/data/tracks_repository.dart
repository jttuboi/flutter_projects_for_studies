import 'dart:async';

import 'package:follow_my_tracks/domain/track.dart';

class TracksRepository {
  // this list represent database
  List<Track> tracksDatabase = [
    const Track(name: 'morro da verdade', imageUrl: 'asd'),
    const Track(name: 'trilha sul', imageUrl: '234'),
    const Track(name: 'trilha centro norte', imageUrl: 'gfh'),
    const Track(name: 'trilha da praia', imageUrl: '567'),
  ];

  Future<List<Track>> fetchTracks() async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return Future.value(tracksDatabase);
    });
  }

  Future<void> saveTrack(Track trackToAdd) async {
    Future.delayed(const Duration(milliseconds: 500), () {
      final indexOfConflicted = tracksDatabase.indexWhere((track) => track.name == trackToAdd.name);
      if (indexOfConflicted == -1) {
        tracksDatabase.add(trackToAdd);
      } else {
        // replace old
        tracksDatabase
          ..removeAt(indexOfConflicted)
          ..insert(indexOfConflicted, trackToAdd);
      }
    });
  }

  Future<void> deleteTrack(Track trackToDelete) async {
    Future.delayed(const Duration(milliseconds: 500), () {
      tracksDatabase.removeWhere((track) => track == trackToDelete);
    });
  }
}
