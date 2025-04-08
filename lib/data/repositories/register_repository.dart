import 'package:flutter_application_7/data/services/register_services.dart';
import'../models/register_model.dart';

class RegisterRepository {
  final RegisterService _registerService=RegisterService();
  Future<RegisterResponseModel?>register(RegisterRequestModel request)async{
    return await _registerService.register(request);
  }
}