import 'package:flutter/material.dart';
import 'package:talent_insider_app/core/constants/color.dart';
import 'package:talent_insider_app/core/themes/style/textstyle.dart';

/// Enumeration representing the various styles of the [TalentButton].
enum TalentButtonStyle {
  primary,
  secondary,
  disabled,
  outlinedBig,
  outlinedSmall,
}

/// A custom button widget that supports multiple styles based on [TalentButtonStyle].
class TalentButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback onPressed;
  final TalentButtonStyle style;

  const TalentButton({
    super.key,
    required this.buttonLabel,
    required this.onPressed,
    this.style = TalentButtonStyle.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: style == TalentButtonStyle.disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: getBorderSide(style),
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(double.infinity, getMinimumHeight(style)),
          backgroundColor: getBackgroundColor(style),
          foregroundColor: getForegroundColor(style),
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        child: FittedBox(child: Text(buttonLabel, style: getTextStyle(style))),
      ),
    );
  }

  Color getForegroundColor(TalentButtonStyle style) {
    switch (style) {
      case TalentButtonStyle.primary:
        return Colors.white;
      case TalentButtonStyle.secondary:
        return AppColors.red;
      case TalentButtonStyle.disabled:
        return Colors.white;
      case TalentButtonStyle.outlinedBig:
      case TalentButtonStyle.outlinedSmall:
        return Colors.white;
    }
  }

  Color getBackgroundColor(TalentButtonStyle style) {
    switch (style) {
      case TalentButtonStyle.primary:
        return AppColors.red;
      case TalentButtonStyle.secondary:
      case TalentButtonStyle.disabled:
        return Colors.white;
      case TalentButtonStyle.outlinedBig:
      case TalentButtonStyle.outlinedSmall:
        return Colors.transparent;
    }
  }

  BorderSide getBorderSide(TalentButtonStyle style) {
    if (style == TalentButtonStyle.disabled ||
        style == TalentButtonStyle.outlinedBig ||
        style == TalentButtonStyle.outlinedSmall) {
      return BorderSide(width: 1.0, color: AppColors.white);
    }
    return BorderSide.none;
  }

  double getMinimumHeight(TalentButtonStyle style) {
    if (style == TalentButtonStyle.outlinedSmall) {
      return 30;
    }
    return 40;
  }

  TextStyle getTextStyle(TalentButtonStyle style) {
    if (style == TalentButtonStyle.outlinedSmall) {
      return TalentTextStyle.xsSemibold.copyWith(color: Colors.white);
    } else if (style == TalentButtonStyle.disabled) {
      return TalentTextStyle.smSemibold.copyWith(color: Colors.white);
    }
    return TalentTextStyle.smSemibold;
  }
}
