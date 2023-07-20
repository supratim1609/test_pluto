import 'package:music_app/models/track.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/trackdetails.dart';

class TrackRepository {
  final String apiKey = '5505dec9f49623a724faeb5e2bfc83cb';
  final String baseUrl = 'https://api.musixmatch.com/ws/1.1';

  Future<List<Track>> getTracks() async {
    final response = await http.get(Uri.parse('$baseUrl/chart.tracks.get?apikey=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final trackList = data['message']['body']['track_list'] as List;
      return trackList.map((item) => Track.fromJson(item['track'])).toList();
    } else {
      throw Exception('Failed to load tracks.');
    }
  }

  Future<TrackDetails> getTrackDetails(int trackId) async {
    final response = await http.get(Uri.parse('$baseUrl/track.get?track_id=$trackId&apikey=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final trackData = data['message']['body']['track'];
      return TrackDetails.fromJson(trackData);
    } else {
      throw Exception('Failed to fetch track details.');
    }
  }

  Future<String> getLyrics(int trackId) async {
    final response = await http.get(Uri.parse('$baseUrl/track.lyrics.get?track_id=$trackId&apikey=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final lyrics = data['message']['body']['lyrics']['lyrics_body'];
      return lyrics;
    } else {
      throw Exception('Failed to fetch lyrics.');
    }
  }
}

