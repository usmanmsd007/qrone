part of 'product_type_bloc.dart';

abstract class ProductTypeState extends Equatable {
  const ProductTypeState();

  @override
  List<Object> get props => [];
}

class ProductTypeInitial extends ProductTypeState {}

class ProductTypeLoadingState extends ProductTypeState {}

class ProductTypeScueessState extends ProductTypeState {
  final List<ProductTypeEntity> m;
  const ProductTypeScueessState({required this.m});
}

class ProductTypeErrorState extends ProductTypeState {
  final String e;
  const ProductTypeErrorState({
    required this.e,
  });
}
