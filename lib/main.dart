import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/bloc/track_bloc.dart';
import 'package:music_app/pages/home_page.dart';
import 'package:music_app/services/track_repository.dart';

void main() {
  final TrackRepository trackRepository = TrackRepository();
  final TrackBloc trackBloc = TrackBloc(trackRepository: trackRepository);

  runApp(MyApp(trackBloc: trackBloc));
}

class MyApp extends StatelessWidget {
  final TrackBloc trackBloc;

  MyApp({required this.trackBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider.value(
          value: trackBloc..add(LoadTracksEvent()),
          child: HomePage(),
        ),
        '/track_details': (context) => BlocProvider.value(
          value: trackBloc,
          // child: TrackDetailsPage(),
        ),
      },
    );
  }
}


