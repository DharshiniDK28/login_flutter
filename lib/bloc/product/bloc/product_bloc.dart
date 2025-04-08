import 'package:flutter_application_7/bloc/datafetch_bloc/datafetch_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_7/bloc/product/bloc/product_event.dart';
import 'package:flutter_application_7/bloc/product/bloc/product_state.dart';
import 'package:flutter_application_7/data/repositories/product_repository.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(const ProductState()) {
    on<ProductFetched>(_onProductFetched);
    on<ProductPageLoaded>(_onProductPageLoaded);
    on<ProductPageFailed>(_onProductPageFailed);
  }

  Future<void> _onProductFetched(ProductFetched event, Emitter<ProductState> emit) async {
   
    final isInitial = state.fetchStatus is InitialFetchStatus;
    emit(
      state.copyWith(fetchStatus: isInitial ? const FetchingData() : const RefreshingData()));

    try {
      final products = await productRepository.getProducts();
      emit(state.copyWith(products: products, fetchStatus: const FetchSuccess()));
    } catch (e) {
      emit(
        state.copyWith(fetchStatus: FetchFailure(e.toString())));
    }
  }

  void _onProductPageLoaded(ProductPageLoaded event, Emitter<ProductState> emit) {
    emit(
      state.copyWith(fetchStatus: const FetchSuccess()));
  }

  void _onProductPageFailed(ProductPageFailed event, Emitter<ProductState> emit) {
    emit(
      state.copyWith(fetchStatus: FetchFailure(event.error)));
  }
}
