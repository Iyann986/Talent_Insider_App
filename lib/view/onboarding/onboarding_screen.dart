import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/constants/app_label.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';
import 'package:talent_insider_app/view/login/login_screen.dart';
import 'package:talent_insider_app/view/nav_bar/nav_bar_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const id = '/onboardingScreen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<String> imagePaths = [
    ResourcePath.onboarding1,
    ResourcePath.onboarding2,
    ResourcePath.onboarding3,
  ];

  final List<String> titles = [
    AppLabel.onboardingTitle1,
    AppLabel.onboardingTitle2,
    AppLabel.onboardingTitle3,
  ];

  final List<String> descriptions = [
    AppLabel.onboardingDescription1,
    AppLabel.onboardingDescription2,
    AppLabel.onboardingDescription3,
  ];

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = !(prefs.getBool('login') ?? true);

    if (isLoggedIn && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBarScreen(initialIndex: 0),
        ),
      );
    }
  }

  void handleButtonNavigation() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = !(prefs.getBool('login') ?? true);

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBarScreen(initialIndex: 0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            onLoginSuccess: (user) {
              debugPrint('Login berhasil: ${user.user.email}');
            },
            onLoginError: (message) {
              debugPrint('Login error: $message');
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.blackDark,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return buildOnboardingItem(
                      imagePaths[index],
                      titles[index],
                      descriptions[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: (_currentPage < imagePaths.length - 1)
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: handleButtonNavigation,
                            child: Text(
                              'Skip',
                              style: TalentTextStyle.smSemibold.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: handleButtonNavigation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Lanjut',
                            style: TalentTextStyle.smSemibold.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOnboardingItem(
    String imagePath,
    String title,
    String description,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 20,
            left: 17,
            right: 17,
          ),
          child: Image.asset(imagePath),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TalentTextStyle.mdSemibold.copyWith(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            description,
            style: TalentTextStyle.smRegular.copyWith(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 24),
        buildPageIndicator(),
      ],
    );
  }

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        imagePaths.length,
        (index) => buildIndicator(index),
      ),
    );
  }

  Widget buildIndicator(int index) {
    double size = 8.0;
    bool isCurrentPage = index == _currentPage;
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrentPage ? AppColors.red : const Color(0xFFD0D5DD),
      ),
    );
  }
}
