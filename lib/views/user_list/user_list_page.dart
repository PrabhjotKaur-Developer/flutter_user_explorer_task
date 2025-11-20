import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/user_controller.dart';
import '../../utils/constants.dart';
import '../user_details/user_details_page.dart';
import 'widgets/user_tile.dart';
import 'widgets/search_bar.dart';

class UserListPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  UserListPage({super.key});

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
            stops:  [0.0, 0.3, 1.0],
          )
              : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.gradientTopLeft,
              AppConstants.gradientTopRight,
              AppConstants.gradientBottom,
            ],
            stops:  [0.0, 0.3, 1.0],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "User Explorer",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            centerTitle: false,
            actions: [
              Obx(() {
                if (userController.isOfflineMode.value) {
                  return Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppConstants.iconCyan,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.wifi_off, size: 14, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          "OFFLINE MODE",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              Obx(() => IconButton(
                icon: Icon(
                  userController.isDarkMode.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: userController.toggleTheme,
              )),
            ],
          ),
          body: Column(
            children: [
               SizedBox(height: 10),

              UserSearchBar(onSearch: userController.filterUsers),

               SizedBox(height: 15),
              Expanded(
                child: Obx(() {
                  if (userController.isLoading.value &&
                      userController.filteredUsers.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppConstants.iconCyan,
                      ),
                    );
                  }

                  if (userController.filteredUsers.isEmpty) {
                    String displayMessage;
                    bool isSeriousError = false;

                    if (userController.errorMessage.isNotEmpty) {
                      if (userController.isOfflineMode.value) {
                        displayMessage = 'No matching users found in cache.';
                      } else {
                        displayMessage = userController.errorMessage.value;
                        isSeriousError = true;
                      }
                    } else if (userController.searchQuery.value.isNotEmpty) {
                      displayMessage =
                      'No users found for "${userController.searchQuery.value}"';
                    } else {
                      displayMessage = 'No users available.';
                    }

                    return Center(
                      child: Padding(
                        padding:  EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isSeriousError
                                  ? Icons.error_outline
                                  : Icons.person_search,
                              size: 60,
                              color: isSeriousError
                                  ? AppConstants.errorColor
                                  : AppConstants.textGrey,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              displayMessage,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: isSeriousError
                                    ? AppConstants.errorColor
                                    : AppConstants.textGrey,
                              ),
                            ),
                            if (isSeriousError)
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: ElevatedButton.icon(
                                  onPressed: userController.fetchUsers,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Try Again'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppConstants.iconCyan,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: userController.fetchUsers,
                    color: AppConstants.iconCyan,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: userController.filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = userController.filteredUsers[index];
                        return UserTile(
                          user: user,
                          index: index,
                          onTap: () {
                            Get.to(
                                  () => UserDetailsPage(),
                              arguments: user,
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}