import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_7/data/repositories/login_repository.dart';
import 'package:flutter_application_7/data/repositories/register_repository.dart';
import 'package:flutter_application_7/data/repositories/product_repository.dart';
import 'package:flutter_application_7/data/services/product_services.dart';
import 'package:flutter_application_7/router_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepository(),
        ),
        RepositoryProvider<RegisterRepository>(
          create: (context) => RegisterRepository(),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(
            productService: ProductService(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Login App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router, 
      ),
    );
  }
}
