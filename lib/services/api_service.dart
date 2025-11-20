import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../utils/constants.dart';

class ApiService {
  // final http.Client client = http.Client();

  Future<List<User>> fetchUsers() async {
    try {
      final uri = Uri.parse(AppConstants.userListUrl);
      final response = await http.get(uri);
      print("your response in this api is $response");

      var data = json.decode(response.body);
      print("your response in this api is $data");
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: Status Code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}