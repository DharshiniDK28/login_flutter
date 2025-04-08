import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_7/bloc/form_bloc/form_submission_status.dart';
import 'package:flutter_application_7/bloc/register_bloc/bloc/register_state.dart';
import 'package:flutter_application_7/data/models/register_model.dart';
import 'package:flutter_application_7/data/repositories/register_repository.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc({required this.registerRepository})
      : super(const RegisterState()) {
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

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email,
        formStatus: const FormEditing(),
      ));
    });

    on<RegisterSubmitted>((event, emit) async {
      if (!state.isValidUsername || !state.isValidPassword || !state.isValidEmail) {
        emit(state.copyWith(formStatus: SubmissionFailed("Invalid username, password or email")));
        return;
      }

      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        final registerRequest = RegisterRequestModel(
          username: state.username,
          password: state.password,
          email: state.email,
        );

        final user = await registerRepository.register(registerRequest);

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
