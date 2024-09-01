import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/domain/track.dart';
import 'package:follow_my_tracks/domain/tracks_cubit.dart';
import 'package:follow_my_tracks/presentation/routes.dart';

class TracksPage extends StatefulWidget {
  const TracksPage({Key? key}) : super(key: key);

  @override
  _TracksPageState createState() => _TracksPageState();
}

class _TracksPageState extends State<TracksPage> {
  @override
  void initState() {
    super.initState();
    context.read<TracksCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TracksCubit, TracksState>(
      builder: (context, state) {
        if (state is TracksLoading) {
          return _buildLoadingContent();
        }
        if (state is TracksError) {
          return _buildErrorContent();
        }

        final tracks = (state as TracksLoaded).tracks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tracks'),
            actions: [
              _buildAddTrackButton(context),
            ],
          ),
          body: ListView.separated(
            shrinkWrap: true,
            itemCount: tracks.length,
            itemBuilder: (context, index) => _buildTrackTile(tracks[index], context),
            separatorBuilder: (context, index) => const Divider(height: 0),
          ),
        );
      },
    );
  }

  Widget _buildLoadingContent() {
    return Scaffold(
      appBar: AppBar(title: const Text('Tracks')),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorContent() {
    return Scaffold(
      appBar: AppBar(title: const Text('Tracks')),
      body: const Center(child: Text('Some error ocurred go back page.')),
    );
  }

  Widget _buildAddTrackButton(BuildContext context) {
    return InkWell(
      onTap: () => _goToAddTrack(context),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTrackTile(Track track, BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context, track),
      onDoubleTap: () => _goToEditTrack(context, track),
      onLongPress: () => _goToEditTrack(context, track),
      child: Dismissible(
        key: ObjectKey(track),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: const EdgeInsets.only(right: 16),
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: const Icon(Icons.delete),
        ),
        onDismissed: (direction) => _deleteTrack(direction, track, context),
        child: ListTile(
          title: Text(track.name),
        ),
      ),
    );
  }

  void _goToAddTrack(BuildContext context) {
    Navigator.pushNamed(context, addTrackRoute).then((value) {
      context.read<TracksCubit>().refresh();
    });
  }

  void _goToEditTrack(BuildContext context, Track track) {
    Navigator.pushNamed(context, editTrackRoute, arguments: track).then((value) {
      context.read<TracksCubit>().refresh();
    });
  }

  void _deleteTrack(DismissDirection direction, Track track, BuildContext context) {
    if (direction == DismissDirection.endToStart) {
      context.read<TracksCubit>().deleteTrack(track);
    }
  }
}
