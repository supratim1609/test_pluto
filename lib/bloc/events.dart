import 'package:music_app/bloc/track_bloc.dart';

class LoadTrackDetailsEvent extends TrackEvent {
  final int trackId;

  LoadTrackDetailsEvent(this.trackId);

  @override
  List<Object?> get props => [trackId];
}

class LoadLyricsEvent extends TrackEvent {
  final int trackId;

  LoadLyricsEvent(this.trackId);

  @override
  List<Object?> get props => [trackId];
}
