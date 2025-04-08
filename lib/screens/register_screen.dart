import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_7/bloc/register_bloc/bloc/register_bloc.dart';
import 'package:flutter_application_7/bloc/register_bloc/bloc/register_state.dart';
import 'package:flutter_application_7/bloc/form_bloc/form_submission_status.dart';
import 'package:flutter_application_7/data/repositories/register_repository.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        registerRepository: context.read<RegisterRepository>(),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF3E0),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Create an account to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                const Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return TextField(
                      controller: _usernameController,
                      onChanged: (value) {
                        context.read<RegisterBloc>().add(UsernameChanged(value));
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        hintText: 'Enter your username',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        context.read<RegisterBloc>().add(EmailChanged(value));
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        hintText: 'Enter your email',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return TextField(
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        context.read<RegisterBloc>().add(PasswordChanged(value));
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        hintText: 'Enter your password',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),

                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state.formStatus is SubmissionSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registration Successful'),
                          backgroundColor: Color.fromARGB(255, 31, 221, 50),
                        ),
                      );
                      context.go('/products');
                    } else if (state.formStatus is SubmissionFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text((state.formStatus as SubmissionFailed).exception.toString()),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state.formStatus is FormEditing) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8D6E63),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: state.formStatus is FormSubmitting
                            ? null
                            : () {
                                context.read<RegisterBloc>().add(RegisterSubmitted());
                              },
                        child: state.formStatus is FormSubmitting
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Sign up', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(color: Color(0xFF5D4037)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
