
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/user_model.dart';
import '../../utils/constants.dart';
import '../../controllers/user_controller.dart';

class UserDetailsPage extends StatelessWidget {
  final User user = Get.arguments as User;
  final UserController userController = Get.find<UserController>();

  UserDetailsPage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Get.snackbar('Error', 'Could not launch $url',
      //     snackPosition: SnackPosition.BOTTOM);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = userController.isDarkMode.value;

      return Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.darkGradientTopLeft,
              AppConstants.darkGradientTopRight,
              AppConstants.darkGradientBottom,
            ],
            stops: const [0.0, 0.3, 1.0],
          )
              : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.gradientTopLeft,
              AppConstants.gradientTopRight,
              AppConstants.gradientBottom,
            ],
            stops: const [0.0, 0.3, 1.0],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Get.back(),
            ),
            title: Text(
              'User Explorer',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppConstants.avatarGreen,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  user.name,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppConstants.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 2),

                Text(
                  '${user.username}',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: isDark
                        ? Colors.grey.shade400
                        : Colors.black,
                  ),
                ),

                const SizedBox(height: 30),

                _buildSectionCard(
                  isDark: isDark,
                  title: 'Contact Information',
                  children: [
                    _buildDetailRow(
                      isDark: isDark,
                      icon: Icons.email,
                      iconColor: AppConstants.iconCyan,
                      label: 'Email',
                      value: user.email,
                      onTap: () => _launchUrl('mailto:${user.email}'),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      isDark: isDark,
                      icon: Icons.phone,
                      iconColor: AppConstants.iconOrange,
                      label: 'Phone',
                      value: user.phone,
                      onTap: () => _launchUrl('tel:${user.phone}'),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      isDark: isDark,
                      icon: Icons.language,
                      iconColor: AppConstants.iconGreen,
                      label: 'Website',
                      value: user.website,
                      onTap: () => _launchUrl('https://${user.website}'),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildSectionCard(
                  isDark: isDark,
                  title: 'Address',
                  children: [
                    _buildDetailRow(
                      isDark: isDark,
                      icon: Icons.apartment,
                      iconColor: AppConstants.iconCyan,
                      label: 'Street/Suite',
                      value: '${user.address.street}, ${user.address.suite}',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      isDark: isDark,
                      icon: Icons.location_city,
                      iconColor: AppConstants.iconOrange,
                      label: 'City/Zipcode',
                      value: '${user.address.city}, ${user.address.zipcode}',
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildSectionCard(
                  isDark: isDark,
                  title: 'Company',
                  children: [
                    _buildDetailRow(
                      isDark: isDark,
                      icon: Icons.business_center,
                      iconColor: AppConstants.iconCyan,
                      label: 'Name',
                      value: user.company.name,
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      isDark: isDark,
                      icon: Icons.lightbulb_outline,
                      iconColor: AppConstants.iconOrange,
                      label: 'Catch Phrase',
                      value: user.company.catchPhrase,
                      isItalic: true,
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      isDark: isDark,
                      icon: Icons.assessment,
                      iconColor: AppConstants.iconGreen,
                      label: 'Business Strategy',
                      value: user.company.bs,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSectionCard({
    required bool isDark,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: isDark ? Colors.white : AppConstants.textDark,
            ),
          ),
          Divider(
              height: 20,
              color: isDark ? Color(0xFFB4B0B0) : Color(0xFFB4B0B0),
            ),
          const SizedBox(height: 6),
          // ...children,
        ]..addAll(children),
      ),
    );
  }


  Widget _buildDetailRow({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    VoidCallback? onTap,
    bool isItalic = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: isDark
                        ? Colors.grey.shade400
                        : AppConstants.textGrey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                    color: isDark ? Colors.white : AppConstants.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}