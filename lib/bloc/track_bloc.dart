import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_app/models/track.dart';
import 'package:music_app/services/track_repository.dart';

import 'events.dart';

// State for the TrackBloc
class TrackState extends Equatable {
  final List<Track> tracks;
  final bool isLoading;
  final String error;

  const TrackState({required this.tracks, required this.isLoading, required this.error});

  @override
  List<Object?> get props => [tracks, isLoading, error];

  TrackState copyWith({List<Track>? tracks, bool? isLoading, String? error}) {
    return TrackState(
      tracks: tracks ?? this.tracks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Events for the TrackBloc
abstract class TrackEvent extends Equatable {
  const TrackEvent();

  @override
  List<Object?> get props => [];
}

class LoadTracksEvent extends TrackEvent {}

// TrackBloc
class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository trackRepository;

  TrackBloc({required this.trackRepository}) : super(TrackState(tracks: [], isLoading: false, error: ''));

  @override
  Stream<TrackState> mapEventToState(TrackEvent event) async* {
    if (event is LoadTracksEvent) {
      yield state.copyWith(isLoading: true, error: '');
      try {
        final tracks = await trackRepository.getTracks();
        yield state.copyWith(tracks: tracks, isLoading: false, error: '');
      } catch (e) {
        yield state.copyWith(isLoading: false, error: 'Failed to load tracks.');
      }
    }
    else if (event is LoadTrackDetailsEvent) {
      try {
        final trackDetails = await trackRepository.getTrackDetails(event.trackId);
        // You can update the state with the fetched track details here
      } catch (e) {
        // Handle the error
      }
    } else if (event is LoadLyricsEvent) {
      try {
        final lyrics = await trackRepository.getLyrics(event.trackId);
        // You can update the state with the fetched lyrics here
      } catch (e) {
        // Handle the error
      }
    }
  }
}