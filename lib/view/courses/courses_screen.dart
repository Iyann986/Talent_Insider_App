import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/constants/app_label.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';
import 'package:talent_insider_app/view/courses/detail_course_screen.dart';
import 'package:talent_insider_app/view_model/courses_view_model/courses_view_model.dart';

class CoursesScreen extends StatefulWidget {
  static const id = '/coursesScreen';
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final List<String> filters = const [
    'For You',
    'Recent',
    'Trending',
    'Technology',
  ];

  final List<Map<String, dynamic>> coursess = [
    {
      'isNew': true,
      'image': 'assets/images/onboarding3.png',
      'title': 'Figma UX Design UI Essential Course',
      'mentor': 'David Rockwell',
      'level': 'Beginner',
      'category': 'Design',
      'duration': '1:20:10',
      'videoCount': 16,
      'countryFlag': '🇬🇧',
    },
    {
      'isNew': false,
      'image': 'assets/images/onboarding3.png',
      'title': 'ChatGPT & Midjourney: 23 Ways of Earning Money with AI',
      'mentor': 'Diego Davila',
      'level': 'Intermediate',
      'category': 'AI',
      'duration': '30:15',
      'videoCount': 3,
      'countryFlag': '🌎',
    },
    {
      'isNew': true,
      'image': 'assets/images/onboarding3.png',
      'title': 'Sales Training: Practical Sales Techniques',
      'mentor': 'Chriss Crott',
      'level': 'Advance',
      'category': 'Sales',
      'duration': '1:20:10',
      'videoCount': 16,
      'countryFlag': '🌎',
    },
    {
      'isNew': true,
      'image': 'assets/images/onboarding3.png',
      'title': 'Membuat Toko Online dengan Laravel 10 - #7 Memasang Tem...',
      'mentor': 'Binus University',
      'level': 'Beginner',
      'category': 'Laravel',
      'duration': '1:20:10',
      'videoCount': 16,
      'countryFlag': '🇮🇩',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CourseViewModel>(context, listen: false).fetchCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseViewModel = Provider.of<CourseViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.black,
        title: Text(
          AppLabel.coursesAppBar,
          style: TalentTextStyle.msMedium.copyWith(
            color: AppColors.white,
            fontSize: 19,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            ResourcePath.tombolBackSvg,
            height: 18,
            width: 18,
            // ignore: deprecated_member_use
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: AppColors.white, size: 24),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                autofocus: false,
                style: TalentTextStyle.smRegular.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                  suffixIcon: const Icon(Icons.tune, color: Colors.white),
                  contentPadding: const EdgeInsets.fromLTRB(10, 15, 20, 15),
                  hintText: 'Title, mentor, or keywords...',
                  hintStyle: const TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: AppColors.blackDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xff222326)),
                        ),
                        label: Text(filters[index]),
                        backgroundColor: Color(0xff222326),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (courseViewModel.state == CourseViewState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (courseViewModel.state == CourseViewState.error) {
                      return Center(
                        child: Text(
                          courseViewModel.errorMessage ??
                              'Something went wrong',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (courseViewModel.courses.isEmpty) {
                      return const Center(
                        child: Text(
                          'No courses available',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemCount: courseViewModel.courses.length,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.white24,
                            thickness: 1,
                            height: 16,
                          );
                        },
                        itemBuilder: (context, index) {
                          final course = courseViewModel.courses[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailCourseScreen(course: course),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: course.path.isNotEmpty
                                        ? Image.network(
                                            course.path[0].url,
                                            width: 100,
                                            height: 120,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                Container(
                                                  width: 100,
                                                  height: 120,
                                                  color: Colors.grey,
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                  ),
                                                ),
                                          )
                                        : Container(
                                            width: 100,
                                            height: 120,
                                            color: Colors.grey,
                                            child: const Icon(
                                              Icons.image_not_supported,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          course.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Container(
                                              height: 26,
                                              width: 26,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Image.network(
                                                  course.path[0].url,
                                                  width: 100,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      Container(
                                                        width: 100,
                                                        height: 120,
                                                        color: Colors.grey,
                                                        child: const Icon(
                                                          Icons.broken_image,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              course.author ?? 'Unknown Mentor',
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 10,
                                              ),
                                            ),
                                            const Spacer(),
                                            _buildBadge(
                                              course.category ?? 'Tidak ada',
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              '🌎',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    ResourcePath.categoryIcon,
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    course.category ??
                                                        'Tidak ada',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Text(
                                                  '16 ',
                                                  style: const TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Image.asset(
                                                  ResourcePath.audioBookIcon,
                                                  height: 16,
                                                  width: 16,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '30:15',
                                              style: const TextStyle(
                                                color: Colors.white54,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.teal, width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Colors.teal,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
