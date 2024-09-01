import 'package:flutter/material.dart';
import 'package:follow_my_tracks/domain/track.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SaveAlertDialog extends StatefulWidget {
  const SaveAlertDialog({required this.markers, required this.polylines, required this.onSaveClicked, this.trackName = '', Key? key})
      : super(key: key);

  final String trackName;
  final List<Marker> markers;
  final List<Polyline> polylines;
  final Function(Track) onSaveClicked;

  @override
  State<SaveAlertDialog> createState() => _SaveAlertDialogState();
}

class _SaveAlertDialogState extends State<SaveAlertDialog> {
  late TextEditingController _textEditingController;
  bool _isTrackNameEmpty = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.trackName);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Give a track name'),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          labelText: 'Track name',
          errorText: _isTrackNameEmpty ? 'Track name can\'t be empty' : null,
          border: const UnderlineInputBorder(),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final trackName = _textEditingController.text.trim();
            setState(() {
              _isTrackNameEmpty = trackName.isEmpty;
            });
            if (trackName.isNotEmpty) {
              final fullTrack = Track(
                name: trackName,
                imageUrl: '',
                markers: widget.markers,
                polylines: widget.polylines,
              );
              widget.onSaveClicked(fullTrack);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
