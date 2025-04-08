import 'package:flutter_application_7/bloc/login_bloc/bloc/login_state.dart';
import 'package:flutter_application_7/data/models/login_model.dart';
import 'package:flutter_application_7/data/repositories/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_7/bloc/form_bloc/form_submission_status.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginState()) {
    on<UsernameChanged>((event, emit) {
      emit(state.copyWith(
        username: event.username,
        formStatus: const FormEditing(), 
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        formStatus: const FormEditing(), 
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      if (!state.isValidUsername || !state.isValidPassword) {
        emit(state.copyWith(
          formStatus: SubmissionFailed("Invalid username or password"),
        ));
        return;
      }

      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        final loginRequest = LoginRequestModel(
          username: state.username,
          password: state.password,
        );

        final user = await loginRepository.login(loginRequest);

        if (user != null) {
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        } else {
          emit(state.copyWith(formStatus: SubmissionFailed("Invalid credentials")));
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    });
  }
}
