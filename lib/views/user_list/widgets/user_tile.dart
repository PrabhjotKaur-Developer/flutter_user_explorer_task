
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants.dart';
import '../../../controllers/user_controller.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  final int index;

  const UserTile({
    required this.user,
    required this.onTap,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    final List<Color> avatarColors = [
      AppConstants.avatarGreen,
      AppConstants.avatarOrange,
      AppConstants.avatarPurple,
      AppConstants.avatarBlue,
    ];

    Color getAvatarColor(int index) {
      return avatarColors[index % avatarColors.length];
    }

    return Obx(() {
      final isDark = userController.isDarkMode.value;

      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin:  EdgeInsets.only(bottom: 12),
          padding:  EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? AppConstants.cardDark.withOpacity(0.8)
                : Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset:  Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: getAvatarColor(index).withOpacity(0.3),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: getAvatarColor(index),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

               SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppConstants.textDark,
                      ),
                    ),
                     SizedBox(height: 3),

                    Text(
                      user.email,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: isDark
                            ? Colors.grey.shade400
                            : AppConstants.textGrey,
                      ),
                    ),
                     SizedBox(height: 2),

                    Text(
                      user.company.name,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: isDark
                            ? Colors.grey.shade500
                            : AppConstants.textGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDark ? Colors.grey.shade500 : AppConstants.textGrey,
              ),
            ],
          ),
        ),
      );
    });
  }
}
