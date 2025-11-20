import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

class UserController extends GetxController {
  late final ApiService _apiService;
  late final CacheService _cacheService;

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var users = <User>[].obs;
  var filteredUsers = <User>[].obs;
  var searchQuery = ''.obs;
  var isOfflineMode = false.obs;
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      _cacheService = Get.put(CacheService());
      await _cacheService.init();
      isDarkMode.value = _cacheService.getTheme();
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

      _apiService = Get.put(ApiService());
      await fetchUsers();
    } catch (e) {
      print('Error initializing services: $e');
      errorMessage('Failed to initialize app: $e');
      isLoading(false);
    }
  }

  Future<void> fetchUsers() async {
    isLoading(true);
    errorMessage('');
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isConnected = connectivityResult != ConnectivityResult.none;

    if (!isConnected) {
      final cachedUsers = _cacheService.getUsers();
      if (cachedUsers.isNotEmpty) {
        users.value = cachedUsers;
        filteredUsers.value = cachedUsers;
        isOfflineMode(true);
        errorMessage('Showing cached data. You are offline.');
      } else {
        errorMessage('No internet connection and no cached data available.');
      }
      isLoading(false);
      return;
    }

    isOfflineMode(false);
    try {
      final fetchedUsers = await _apiService.fetchUsers();
      users.value = fetchedUsers;
      filteredUsers.value = fetchedUsers;

      await _cacheService.saveUsers(fetchedUsers);

      errorMessage('');
    } catch (e) {
      print('Error fetching users $e');
      final cachedUsers = _cacheService.getUsers();
      if (cachedUsers.isNotEmpty) {
        users.value = cachedUsers;
        filteredUsers.value = cachedUsers;
        isOfflineMode(true);
        errorMessage('Failed to fetch from API. Showing cached data.');
      } else {
        String errorMsg = e.toString().replaceFirst('Exception: ', '');
        errorMessage(errorMsg);
      }
    } finally {
      isLoading(false);
    }
  }

  void filterUsers(String query) {
    searchQuery(query.toLowerCase());
    if (query.isEmpty) {
      filteredUsers.value = users;
      return;
    }

    filteredUsers.value = users.where((user) {
      return user.name.toLowerCase().contains(searchQuery.value);
          // ||
          // user.email.toLowerCase().contains(searchQuery.value)
          // );
    }).toList();
  }

  void toggleTheme() async{
    isDarkMode(!isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    await _cacheService.saveTheme(isDarkMode.value);
  }

}