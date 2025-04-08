import 'package:flutter_application_7/bloc/form_bloc/form_submission_status.dart';
import 'package:equatable/equatable.dart';


 class RegisterState extends Equatable {
   final String username;
    bool get isValidUsername => username.length > 3;

    final String password;
    bool get isValidPassword =>password.length > 6;
    
    final String email;
    bool get isValidEmail => email.length > 6;

    final FormSubmissionStatus formStatus;
  const RegisterState({
    this.username = '',
    this.password = '',
    this.email='',
    this.formStatus = const InitialFormStatus(),
  });
  RegisterState copyWith({
    String? username,
    String? password,
    String? email,
    FormSubmissionStatus? formStatus,
  }) {
    return RegisterState(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      formStatus: formStatus ?? this.formStatus,
    );
  }
  @override
  List<Object?> get props => [username, password,email, formStatus];
}

