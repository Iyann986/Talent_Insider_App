import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';
import 'package:talent_insider_app/models/courses_model/courses_model.dart';
import 'package:talent_insider_app/view/courses/widgets/chapter_item.dart';
import 'package:talent_insider_app/view_model/chapter_view_model/chapter_view_model.dart';
import 'dart:ui' as ui;

class DetailCourseScreen extends StatefulWidget {
  final CourseModel course;

  const DetailCourseScreen({super.key, required this.course});

  @override
  State<DetailCourseScreen> createState() => _DetailCourseScreenState();
}

class _DetailCourseScreenState extends State<DetailCourseScreen> {
  int selectedTabIndex = 1;

  final List<String> tabs = ['Overview', 'Contents', 'More Like This'];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ChapterViewModel>(
        context,
        listen: false,
      ).fetchChapters(['682b07546d770267fe862b9e', '682b075c6d770267fe862b9f']);
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color white = Colors.white;
    const Color grey = Colors.grey;
    const Color black = Colors.black;
    const Color red = Color(0xFFE50914);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: black,
        body: SafeArea(
          child: Consumer<ChapterViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.state == ChapterViewState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (viewModel.state == ChapterViewState.error) {
                return Center(
                  child: Text(
                    viewModel.errorMessage ?? 'Terjadi kesalahan',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final chapters = viewModel.chapters;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(),
                    child: Stack(
                      children: [
                        widget.course.path.isNotEmpty
                            ? Image.network(
                                widget.course.path[0].url,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Colors.grey,
                                  child: const Icon(Icons.broken_image),
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.grey,
                                child: const Icon(Icons.image_not_supported),
                              ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: SafeArea(
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.course.title,
                      style: TalentTextStyle.msMedium.copyWith(
                        color: white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF4A4A4A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.memory, color: grey, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'AI',
                            style: TextStyle(
                              color: grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Text(
                          'Created by ',
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Text(
                          'Diego Davila',
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text('🌎', style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 6),
                            const Text(
                              'in English',
                              style: TextStyle(
                                color: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '4 Chapters • 10 Lesson • 30m 15s Total Length',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTabs(
                      selectedIndex: selectedTabIndex,
                      onTabSelected: (index) {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        itemCount: chapters.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final chapter = chapters[index];
                          return ChapterItem(
                            chapter: chapter,
                            chapterIndex: index + 1,
                            isBlackBg: index % 2 == 0,
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue Last',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: white,
                              ),
                            ),
                            Icon(
                              Icons.play_arrow_rounded,
                              size: 28,
                              color: white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    const double tabHeight = 48;
    Color activeBgColor = AppColors.darkGray;
    final Color inactiveBgColor = Colors.transparent;
    const Color activeTextColor = Colors.white;
    final Color inactiveTextColor = Colors.grey;

    final tabs = ['Overview', 'Contents', 'More Like This'];

    return Container(
      height: tabHeight + 16,
      child: Stack(
        children: [
          Positioned(
            top: tabHeight - 12,
            left: 0,
            right: 0,
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.darkGray,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: List.generate(tabs.length, (index) {
              final bool isActive = index == selectedIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTabSelected(index),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: tabHeight,
                        decoration: BoxDecoration(
                          color: isActive ? activeBgColor : inactiveBgColor,
                          borderRadius: isActive
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                )
                              : BorderRadius.zero,
                        ),
                      ),
                      if (isActive)
                        Positioned(
                          bottom: -12,
                          child: CustomPaint(
                            size: const Size(64, 24),
                            painter: _TabCurvePainter(color: activeBgColor),
                          ),
                        ),
                      SizedBox(
                        height: tabHeight,
                        child: Center(
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: isActive
                                  ? activeTextColor
                                  : inactiveTextColor,
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _TabCurvePainter extends CustomPainter {
  final Color color;

  _TabCurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = ui.Path(); // fix: pakai ui.Path bukan model Path

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, 0);
    path.quadraticBezierTo(size.width * 0.75, 0, size.width, size.height * 0.3);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 4.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
