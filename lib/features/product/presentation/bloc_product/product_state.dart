part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class GetProductSuccessState extends ProductState {
  final List<ProductEntity> products;
  final List<ProductTypeEntity> productTypes;
  final List<Units> units;
  final List<CompanyEntity> companies;
  const GetProductSuccessState(
      {required this.products,
      required this.productTypes,
      required this.companies,
      required this.units});
}

// class AddProductSuccessState extends ProductState {}

class ProductsLoadingState extends ProductState {}

class SearchProductKeywordState extends ProductState {
  final List<ProductEntity> products;
  final String keyword;
  SearchProductKeywordState({required this.keyword, required this.products});
  @override
  List<Object> get props => [keyword, products];
}

class NextScreenState extends ProductState {
  final List<Units> units;
  final List<CompanyEntity> companies;
  final List<ProductTypeEntity> productTypes;
  const NextScreenState(
      {required this.companies,
      required this.productTypes,
      required this.units});
}

class ProductErrorState extends ProductState {
  final String e;
  ProductErrorState({required this.e});
}
