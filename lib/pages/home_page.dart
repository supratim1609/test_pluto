import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/bloc/track_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Music App'),
      ),
      body: BlocBuilder<TrackBloc, TrackState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.error.isNotEmpty) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return ListView.builder(
              itemCount: state.tracks.length,
              itemBuilder: (context, index) {
                final track = state.tracks[index];
                return ListTile(
                  title: Text(track.name),
                  subtitle: Text(track.artist),
                  onTap: () {
                    Navigator.pushNamed(context, '/track_details', arguments: track.id);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
