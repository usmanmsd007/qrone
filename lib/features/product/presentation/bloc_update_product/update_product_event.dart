part of 'update_product_bloc.dart';

sealed class UpdateProductsEvent extends Equatable {
  const UpdateProductsEvent();

  @override
  List<Object> get props => [];
}

class UpdateBarCodeEvent extends UpdateProductsEvent {
  final String code;

  const UpdateBarCodeEvent({
    required this.code,
  });
}

class UpdateProductEvent extends UpdateProductsEvent {
  final ProductEntity productEntity;
  const UpdateProductEvent({required this.productEntity});
}

class SetInitialTextEvent extends UpdateProductsEvent {
  final String name;
  final double price;
  final int id;
  const SetInitialTextEvent(
      {required this.name, required this.price, required this.id});
}

class UpdateCompanyIndexEvent extends UpdateProductsEvent {
  final CompanyEntity? companyEnitity;
  final Units? unitEntity;
  final ProductTypeEntity? productTypeEntity;

  const UpdateCompanyIndexEvent({
    required this.companyEnitity,
    required this.unitEntity,
    required this.productTypeEntity,
  });
}
