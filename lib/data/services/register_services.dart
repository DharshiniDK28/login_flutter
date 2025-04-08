import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/register_model.dart';

class RegisterService{
  final String baseUrl="https://fakestoreapi.com";
  Future<RegisterResponseModel>register(RegisterRequestModel request)async{
    final response=await http.post(
      Uri.parse("https://fakestoreapi.com/users"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(request.toJson()),
    );
    if(response.statusCode==200){
      return RegisterResponseModel.fromJson(jsonDecode(response.body));
    }
    else{
      print("Register Error: ${response.statusCode}");
      print("Response:${response.body}");
      throw Exception("Failed to register");
    }
  }
}