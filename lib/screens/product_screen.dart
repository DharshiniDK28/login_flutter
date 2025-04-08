import 'package:flutter/material.dart';
import 'package:flutter_application_7/bloc/datafetch_bloc/datafetch_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_7/bloc/product/bloc/product_bloc.dart';
import 'package:flutter_application_7/bloc/product/bloc/product_state.dart';
import 'package:flutter_application_7/bloc/product/bloc/product_event.dart';
import 'package:flutter_application_7/data/repositories/product_repository.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        productRepository: context.read<ProductRepository>(),
      )..add(ProductFetched()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.go('/');
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            final fetchStatus = state.fetchStatus;

            if (fetchStatus is InitialFetchStatus || fetchStatus is FetchingData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (fetchStatus is FetchFailure) {
              return Center(
                child: Text(
                  "Error: ${fetchStatus.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state.products.isEmpty) {
              return const Center(child: Text("No products available."));
            }

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    itemCount: state.products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "\$${product.price}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (fetchStatus is RefreshingData)
                  const Positioned(
                    top: 12,
                    left: 12,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text("Refreshing...", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
