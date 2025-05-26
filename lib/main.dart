import 'package:flutter/material.dart';
import 'package:talent_insider_app/view/courses/courses_screen.dart';
import 'package:talent_insider_app/view/login/login_screen.dart';
import 'package:talent_insider_app/view/onboarding/onboarding_screen.dart';

import 'package:provider/provider.dart';
import 'package:talent_insider_app/view_model/courses_view_model/courses_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CourseViewModel>(
          create: (_) => CourseViewModel()..fetchCourses(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talent Insider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: OnboardingScreen.id,
      routes: {
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        CoursesScreen.id: (context) => const CoursesScreen(),
      },
    );
  }
}
