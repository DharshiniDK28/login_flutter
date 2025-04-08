import 'package:flutter_application_7/data/services/login_services.dart';
import '../models/login_model.dart';

class LoginRepository {
  final LoginService _loginService = LoginService();

  Future<LoginResponseModel?> login(LoginRequestModel request) async {
    return await _loginService.login(request);
  }
}
