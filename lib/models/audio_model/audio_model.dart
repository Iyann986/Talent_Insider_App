class AudioModel {
  final String id;
  final String artist;
  final DateTime createdAt;
  final String description;
  final String isPremium;
  final String languange;
  final List<MediaPath> path;
  final List<MediaPath> thumbnail;
  final String? time;
  final String title;

  AudioModel({
    required this.id,
    required this.artist,
    required this.createdAt,
    required this.description,
    required this.isPremium,
    required this.languange,
    required this.path,
    required this.thumbnail,
    required this.time,
    required this.title,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['_id'] as String? ?? '',
      artist: json['artist'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      description: json['description'] as String? ?? '',
      isPremium: json['isPremium'] as String? ?? '',
      languange: json['languange'] as String? ?? '',
      path: (json['path'] as List? ?? [])
          .map((e) => MediaPath.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnail: (json['thumbnail'] as List? ?? [])
          .map((e) => MediaPath.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: json['time'] as String?,
      title: json['title'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'artist': artist,
      'createdAt': createdAt.toIso8601String(),
      'description': description,
      'isPremium': isPremium,
      'languange': languange,
      'path': path.map((e) => e.toJson()).toList(),
      'thumbnail': thumbnail.map((e) => e.toJson()).toList(),
      'time': time,
      'title': title,
    };
  }
}

class MediaPath {
  final String fileName;
  final String url;

  MediaPath({required this.fileName, required this.url});

  factory MediaPath.fromJson(Map<String, dynamic> json) {
    return MediaPath(
      fileName: json['fileName'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'url': url};
  }
}
