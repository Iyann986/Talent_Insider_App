import 'package:flutter/material.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';

class NavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24.0,
            height: 24.0,
            child: Image.asset(
              iconPath,
              color: isActive ? AppColors.white : AppColors.disable,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TalentTextStyle.smRegular.copyWith(
              fontSize: 10,
              color: isActive ? AppColors.white : AppColors.disable,
            ),
          ),
        ],
      ),
    );
  }
}
