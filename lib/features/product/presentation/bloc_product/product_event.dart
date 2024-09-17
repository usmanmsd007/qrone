part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {}

class CloseSearchBarEvent extends ProductEvent {}

class MoveToNextScreen extends ProductEvent {}

class SearchProductKeywordEvent extends ProductEvent {
  final String keyWord;
  const SearchProductKeywordEvent({required this.keyWord});

  @override
  List<Object> get props => [];
}
