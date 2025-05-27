class ChapterModel {
  final String id;
  final String title;
  final List<Course> coursesId;
  final List<Lesson> lesson;
  final DateTime createdAt;

  ChapterModel({
    required this.id,
    required this.title,
    required this.coursesId,
    required this.lesson,
    required this.createdAt,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['_id'],
      title: json['title'],
      coursesId: (json['coursesId'] as List<dynamic>)
          .map((e) => Course.fromJson(e))
          .toList(),
      lesson: (json['lesson'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'coursesId': coursesId.map((e) => e.toJson()).toList(),
      'lesson': lesson.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Course {
  final String id;
  final String title;

  Course({required this.id, required this.title});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(id: json['_id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'title': title};
  }
}

class Lesson {
  final String id;
  final String title;

  Lesson({required this.id, required this.title});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(id: json['_id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'title': title};
  }
}
