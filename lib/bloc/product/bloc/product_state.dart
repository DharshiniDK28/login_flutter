import 'package:equatable/equatable.dart';
import 'package:flutter_application_7/bloc/datafetch_bloc/datafetch_status.dart';
import 'package:flutter_application_7/data/models/product_model.dart';


class ProductState extends Equatable {
  final List<Product> products;
  final DataFetchStatus fetchStatus;

  const ProductState({
    this.products = const [],
    this.fetchStatus = const InitialFetchStatus(),
  });

  ProductState copyWith({
    List<Product>? products,
    DataFetchStatus? fetchStatus,
  }) {
    return ProductState(
      products: products ?? this.products,
      fetchStatus: fetchStatus ?? this.fetchStatus,
    );
  }

  @override
  List<Object?> get props => [products, fetchStatus];
}
