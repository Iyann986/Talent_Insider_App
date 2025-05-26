import 'package:flutter/material.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/view/courses/nav_courses_screen.dart';
import 'package:talent_insider_app/view/home/home_screen.dart';
import 'package:talent_insider_app/view/nav_bar/widgets/nav_item.dart';
import 'package:talent_insider_app/view/profile/profile_screen.dart';

class NavBarScreen extends StatefulWidget {
  final int initialIndex;
  const NavBarScreen({super.key, required this.initialIndex});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const NavCoursesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackDark,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.blackDark,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: ResourcePath.navHomeIcon,
              label: 'Home',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
              iconPath: ResourcePath.coursesIcon,
              label: 'Courses',
              isActive: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
              },
            ),
            NavItem(
              iconPath: ResourcePath.navProfileIcon,
              label: 'Profile',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
