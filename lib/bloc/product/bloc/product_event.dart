import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductPageLoaded extends ProductEvent {}

class ProductPageFailed extends ProductEvent {
  final String error;

  const ProductPageFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class ProductFetched extends ProductEvent {}
