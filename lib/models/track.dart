class Track {
  final int id;
  final String name;
  final String artist;

  Track({required this.id, required this.name, required this.artist});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['track_id'],
      name: json['track_name'],
      artist: json['artist_name'],
    );
  }
}
