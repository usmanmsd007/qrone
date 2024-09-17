part of 'search_product_bloc.dart';

sealed class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

class SearchByBarCode extends SearchProductEvent {
  final String barCode;
  final List<CompanyEntity> companies;
  final List<Units> units;
  final List<ProductTypeEntity> types;

  const SearchByBarCode(
      {required this.barCode,
      this.companies = const [],
      this.types = const [],
      this.units = const []});
  @override
  List<Object> get props => [barCode];
}
