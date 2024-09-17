part of 'search_product_bloc.dart';

sealed class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object> get props => [];
}

final class SearchProductInitial extends SearchProductState {}

final class SearchProductErrorState extends SearchProductState {
  final String message;
  const SearchProductErrorState({required this.message});
}

final class SearchProductLoadingState extends SearchProductState {}

final class SearchProductSuccessState extends SearchProductState {
  final List<ProductEntity> result;

  const SearchProductSuccessState({required this.result});

  @override
  List<Object> get props => [result];
}
