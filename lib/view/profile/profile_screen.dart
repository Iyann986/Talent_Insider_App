import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_insider_app/core/assets/resource_path.dart';
import 'package:talent_insider_app/core/constants/app_label.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';
import 'package:talent_insider_app/view/login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.veryLightGrey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              onTap: () async {
                // ignore: unnecessary_nullable_for_final_variable_declarations
                final SharedPreferences? prefs =
                    // ignore: await_only_futures
                    await SharedPreferences.getInstance();
                prefs?.clear();
                Navigator.pushAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              title: Text(
                AppLabel.logout,
                style: TalentTextStyle.xsMedium.copyWith(
                  color: AppColors.red,
                  fontSize: 14,
                ),
              ),
              leading: SvgPicture.asset(ResourcePath.logoutIconSvg, height: 20),
            ),
          ),
        ),
      ),
    );
  }
}
