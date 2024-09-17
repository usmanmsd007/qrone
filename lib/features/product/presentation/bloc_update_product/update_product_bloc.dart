import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/companies/domain/usecases/get_company_usecase.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/usecases/update_product.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/features/units/domain/usecases/get_unit_usecase.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductsEvent, UpdateProductState> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  int productId = -1;
  CompanyEntity? selectedCompany;
  ProductTypeEntity? selectedProductTypeEntity;
  Units? selectedUnit;
  String barCode = "";
  final UpdateProductUsecase updateProductUsecase;
  final GetUnitUsecase unitUsecase;
  final GetCompanyUsecase getCompanyUsecase;

  UpdateProductBloc(
      {required this.getCompanyUsecase,
      required this.updateProductUsecase,
      required this.unitUsecase})
      : super(const UpdateProductInitial()) {
    on<UpdateProductsEvent>((event, emit) async {
      if (event is UpdateBarCodeEvent) {
        barCode = event.code;
        emit(UpdateProductInitial(
          companyEntity: selectedCompany,
          unitEntity: selectedUnit,
          barCode: event.code,
          productTypeEntity: selectedProductTypeEntity,
        ));
      }
      if (event is SetInitialTextEvent) {
        name.text = event.name;
        price.text = event.price.toString();
        productId = event.id;
      }
      if (event is UpdateCompanyIndexEvent) {
        selectedCompany = event.companyEnitity;
        selectedUnit = event.unitEntity;
        selectedProductTypeEntity = event.productTypeEntity;

        emit(UpdateProductInitial(
          companyEntity: event.companyEnitity,
          unitEntity: event.unitEntity,
          barCode: barCode,
          productTypeEntity: event.productTypeEntity,
          // controller: controller
        ));
      }
      if (event is UpdateProductEvent) {
        emit((const UpdateProductLoadingState()));
        var addResponse = await updateProductUsecase(event.productEntity);
        addResponse.fold((l) => mapFailureToMessage(l), (r) async {
          emit(UpdateProductSuccessState());
          emit(UpdateProductInitial(
              companyEntity: selectedCompany,
              productTypeEntity: selectedProductTypeEntity,
              unitEntity: selectedUnit,
              barCode: barCode));
        });
      }
    });
  }
  String mapFailureToMessage(Failure failure) {
    print(failure.toString());
    switch (failure.runtimeType) {
      case (InsertDataFailure):
        return "Sorry There was an error in inserting the product. Please try again";
      default:
        return "Unexpected Error , Please try again later.";
    }
  }
}
