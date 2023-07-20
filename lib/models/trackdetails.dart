class TrackDetails {
  final int id;
  final String name;
  final String artist;
  // Add other properties as needed

  TrackDetails({required this.id, required this.name, required this.artist});

  factory TrackDetails.fromJson(Map<String, dynamic> json) {
    return TrackDetails(
      id: json['track_id'],
      name: json['track_name'],
      artist: json['artist_name'],
    );
  }
}
