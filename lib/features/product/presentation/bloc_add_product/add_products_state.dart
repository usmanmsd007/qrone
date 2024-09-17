part of 'add_products_bloc.dart';

sealed class AddProductsState extends Equatable {
  const AddProductsState();

  @override
  List<Object?> get props => [];
}

final class AddProductsInitial extends AddProductsState {
  final CompanyEntity? companyEntity;
  final ProductTypeEntity? productTypeEntity;
  final Units? unitEntity;
  final String barCode;
  // final QRViewController? controller;

  AddProductsInitial(
      {
      // required this.controller,
      this.productTypeEntity,
      this.barCode = "",
      this.companyEntity,
      this.unitEntity});
  @override
  List<Object?> get props => [
        barCode, unitEntity, companyEntity,
        productTypeEntity
        //  controller
      ];
}

final class AddProductLoadingState extends AddProductsState {
  const AddProductLoadingState();
}

class AddProductSuccessState extends AddProductsState {
  const AddProductSuccessState();
}
