class VideoLessonModel {
  final String id;
  final List<Chapter> chapterId;
  final DateTime createdAt;
  final List<PathFile> path;
  final String title;

  VideoLessonModel({
    required this.id,
    required this.chapterId,
    required this.createdAt,
    required this.path,
    required this.title,
  });

  factory VideoLessonModel.fromJson(Map<String, dynamic> json) {
    return VideoLessonModel(
      id: json['_id'],
      chapterId: (json['chapterId'] as List)
          .map((e) => Chapter.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      path: (json['path'] as List).map((e) => PathFile.fromJson(e)).toList(),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chapterId': chapterId.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'path': path.map((e) => e.toJson()).toList(),
      'title': title,
    };
  }
}

class Chapter {
  final String id;
  final String title;

  Chapter({required this.id, required this.title});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(id: json['_id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'title': title};
  }
}

class PathFile {
  final String fileName;
  final String url;

  PathFile({required this.fileName, required this.url});

  factory PathFile.fromJson(Map<String, dynamic> json) {
    return PathFile(fileName: json['fileName'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'url': url};
  }
}
