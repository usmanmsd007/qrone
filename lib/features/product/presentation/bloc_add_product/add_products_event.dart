part of 'add_products_bloc.dart';

sealed class AddProductsEvent extends Equatable {
  const AddProductsEvent();

  @override
  List<Object> get props => [];
}

class UpdateBarCode extends AddProductsEvent {
  final String code;

  const UpdateBarCode({
    required this.code,
  });
}

class AddProductEvent extends AddProductsEvent {
  final ProductEntity productEntity;
  const AddProductEvent({required this.productEntity});
}

class SetCompanyIndexEvent extends AddProductsEvent {
  final CompanyEntity? companyEnitity;
  final Units? unitEntity;
  final ProductTypeEntity? productTypeEntity;

  const SetCompanyIndexEvent({
    required this.companyEnitity,
    required this.unitEntity,
    required this.productTypeEntity,
  });
}

// class SetControllerProductEvent extends AddProductsEvent {
//   // final QRViewController controller;

//   const SetControllerProductEvent(
//       // {
//       // required this.controller,
//       // }
//       );
// }
