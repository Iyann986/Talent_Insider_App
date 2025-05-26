class CourseModel {
  final String id;
  final String? author;
  final String? category;
  final List<Chapter> chapter;
  final DateTime createdAt;
  final List<Path> path;
  final String title;

  CourseModel({
    required this.id,
    this.author,
    this.category,
    required this.chapter,
    required this.createdAt,
    required this.path,
    required this.title,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json['_id'] as String,
    author: json['author'] as String?,
    category: json['category'] as String?,
    chapter: (json['chapter'] as List<dynamic>)
        .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: DateTime.parse(json['createdAt'] as String),
    path: (json['path'] as List<dynamic>)
        .map((e) => Path.fromJson(e as Map<String, dynamic>))
        .toList(),
    title: json['title'] as String,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'author': author,
    'category': category,
    'chapter': chapter.map((e) => e.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'path': path.map((e) => e.toJson()).toList(),
    'title': title,
  };
}

class Chapter {
  final String id;
  final String title;

  Chapter({required this.id, required this.title});

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      Chapter(id: json['_id'] as String, title: json['title'] as String);

  Map<String, dynamic> toJson() => {'_id': id, 'title': title};
}

class Path {
  final String fileName;
  final String url;

  Path({required this.fileName, required this.url});

  factory Path.fromJson(Map<String, dynamic> json) =>
      Path(fileName: json['fileName'] as String, url: json['url'] as String);

  Map<String, dynamic> toJson() => {'fileName': fileName, 'url': url};
}
