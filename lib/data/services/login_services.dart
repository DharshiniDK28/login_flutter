import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';

class LoginService {
  final String baseUrl = "https://fakestoreapi.com"; 

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await http.post(
      Uri.parse("https://fakestoreapi.com/users"), 
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      print("Login Error: ${response.statusCode}");
      print("Response: ${response.body}");
      throw Exception("Failed to login");
    }
  }
}
