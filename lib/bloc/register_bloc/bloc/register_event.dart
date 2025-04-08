part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}
class UsernameChanged extends RegisterEvent{
  final String username;
  
  const UsernameChanged(this.username);
  @override
  List<Object>get props=>[username];
}
class PasswordChanged extends RegisterEvent{
  final String password;
  
  const PasswordChanged(this.password);
  @override
  List<Object>get props=>[password];
}
class EmailChanged extends RegisterEvent{
  final String email;
  
  const EmailChanged(this.email);
  @override
  List<Object>get props=>[email];
}
class RegisterSubmitted extends RegisterEvent{}