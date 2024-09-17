part of 'product_type_bloc.dart';

abstract class ProductTypeEvent extends Equatable {
  const ProductTypeEvent();

  @override
  List<Object> get props => [];
}

class InsertProductTypeEvent extends ProductTypeEvent {
  final ProductTypeEntity productType;
  const InsertProductTypeEvent({required this.productType});
}

class GetProductTypeEvent extends ProductTypeEvent {
  const GetProductTypeEvent();
}
