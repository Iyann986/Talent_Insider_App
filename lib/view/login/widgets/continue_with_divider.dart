import 'package:flutter/material.dart';
import 'package:talent_insider_app/core/constants/app_label.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';

class ContinueWithDividerNew extends StatelessWidget {
  const ContinueWithDividerNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(child: Divider(color: AppColors.grey)),
          const SizedBox(width: 14),
          Text(
            AppLabel.orContinueWith,
            style: TalentTextStyle.mobileCaption.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 14),
          const Flexible(child: Divider(color: AppColors.grey)),
        ],
      ),
    );
  }
}
