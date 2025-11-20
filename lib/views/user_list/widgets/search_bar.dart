import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/constants.dart';

class UserSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final String hintText;

  const UserSearchBar({
    required this.onSearch,
    this.hintText = 'Find users by name...',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Obx(() {
      final isDark = userController.isDarkMode.value;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? AppConstants.cardDark.withOpacity(0.8)
                : Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            onChanged: onSearch,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: isDark ? Colors.white : AppConstants.textDark,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 15,
                color: isDark
                    ? Colors.grey.shade500
                    : AppConstants.textGrey,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: isDark
                    ? Colors.grey.shade500
                    : AppConstants.textGrey,
                size: 22,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ),
      );
    });
  }
}


