import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foody/utils/constants.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem(
    this.icon, {
    super.key,
    this.onTap,
    this.color = const Color(0xff372948),
    this.activeColor,
    this.isActive = false,
    this.isNotified = false,
  });

  final String icon;
  final Color color;
  final Color? activeColor;
  final bool isNotified;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
              isActive ? AppColors.primaryColor : color, BlendMode.srcIn),
          width: 23,
          height: 23,
        ),
      ),
    );
  }
}
