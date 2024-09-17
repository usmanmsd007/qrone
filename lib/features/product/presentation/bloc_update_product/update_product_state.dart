part of 'update_product_bloc.dart';

sealed class UpdateProductState extends Equatable {
  const UpdateProductState();

  @override
  List<Object?> get props => [];
}

final class UpdateProductInitial extends UpdateProductState {
  final CompanyEntity? companyEntity;
  final ProductTypeEntity? productTypeEntity;
  final Units? unitEntity;
  final String barCode;

  const UpdateProductInitial(
      {this.productTypeEntity,
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

final class UpdateProductLoadingState extends UpdateProductState {
  const UpdateProductLoadingState();
}

class UpdateProductSuccessState extends UpdateProductState {
  const UpdateProductSuccessState();
}
