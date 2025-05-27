import 'package:flutter/material.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/models/chapter_model/chapter_model.dart';
import 'package:talent_insider_app/view/courses/video_lesson_screen.dart';

class ChapterItem extends StatefulWidget {
  final ChapterModel chapter;
  final bool isBlackBg;
  final int chapterIndex;

  const ChapterItem({
    super.key,
    required this.chapterIndex,
    required this.chapter,
    this.isBlackBg = true,
  });

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isBlackBg ? Colors.black : Colors.grey.shade800;
    final white = Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
        backgroundColor: bgColor,
        collapsedBackgroundColor: bgColor,
        trailing: const SizedBox.shrink(),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chapter ${widget.chapterIndex}',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${widget.chapter.lesson.length} Lesson${widget.chapter.lesson.length > 1 ? "s" : ""} • ${'12'} min',
                  style: TextStyle(color: white, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.chapter.title,
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),

        children: List.generate(widget.chapter.lesson.length, (index) {
          final lesson = widget.chapter.lesson[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoLessonScreen(lessonId: lesson.id),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        ResourcePath.thumbnailLogo,
                        width: 80,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lesson ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              lesson.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.play_arrow_rounded, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '14 mins',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Divider(color: Colors.grey.shade700, thickness: 0.5),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
