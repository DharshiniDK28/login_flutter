
import 'package:flutter_application_7/bloc/product/bloc/product_bloc.dart';
import 'package:flutter_application_7/bloc/product/bloc/product_event.dart';
import 'package:flutter_application_7/data/repositories/product_repository.dart';
import 'package:flutter_application_7/data/repositories/login_repository.dart';
import 'package:flutter_application_7/bloc/login_bloc/bloc/login_bloc.dart'; // Ensure this path is correct
import 'package:flutter_application_7/screens/login_screen.dart';
import 'package:flutter_application_7/screens/product_screen.dart';
import 'package:flutter_application_7/screens/register_screen.dart'; // make sure this exists
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
  path: '/',
  builder: (context, state) {
    final loginRepo = context.read<LoginRepository>();
    return BlocProvider(
      create: (_) => LoginBloc(loginRepository: loginRepo),
      child: LoginScreen(),
    );
  },
),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
  path: '/products',
  builder: (context, state) {
    final productRepository = context.read<ProductRepository>();
    return BlocProvider(
      create: (_) => ProductBloc(productRepository: productRepository)..add(ProductFetched()),
      child: const ProductScreen(),
    );
  },
),

  ],
);
