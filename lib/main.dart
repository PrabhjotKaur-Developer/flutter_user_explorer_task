import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/user_controller.dart';
import 'utils/constants.dart';
import 'views/user_list/user_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    // Get.put(CacheService())..init();
  Get.put(UserController());

  runApp( UserExplorerApp());
}

class UserExplorerApp extends StatelessWidget {
   UserExplorerApp({super.key});

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'User Explorer',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          primary: AppConstants.primaryColor,
          secondary: AppConstants.accentColor,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppConstants.accentColor,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.dark,
          primary: AppConstants.primaryColor,
          secondary: AppConstants.accentColor,
          surface: Colors.grey[900]!,
          onSurface: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey[850],
      ),
      themeMode: userController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,

      home: UserListPage(),
      // routes: {
      //   AppConstants.userListRoute: (context) => UserListPage(),
      // },
    ));
  }
}
