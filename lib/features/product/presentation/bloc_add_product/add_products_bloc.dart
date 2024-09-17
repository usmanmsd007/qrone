import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/companies/domain/usecases/get_company_usecase.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/usecases/add_product_usecase.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/features/units/domain/usecases/get_unit_usecase.dart';

part 'add_products_event.dart';
part 'add_products_state.dart';

class AddProductsBloc extends Bloc<AddProductsEvent, AddProductsState> {
  // QRViewController? controller;
  CompanyEntity? selectedCompany;
  ProductTypeEntity? selectedProductTypeEntity;
  Units? selectedUnit;
  String barCode = "";
  final AddProductsUsecase addProductsUsecase;
  final GetUnitUsecase unitUsecase;
  final GetCompanyUsecase getCompanyUsecase;
  AddProductsBloc(
      {required this.getCompanyUsecase,
      required this.addProductsUsecase,
      required this.unitUsecase})
      : super(AddProductsInitial()) {
    on<AddProductsEvent>((event, emit) async {
      if (event is UpdateBarCode) {
        barCode = event.code;
        emit(AddProductsInitial(
          companyEntity: selectedCompany,
          unitEntity: selectedUnit,
          barCode: event.code,
          // controller: controller
        ));
      }
      if (event is SetCompanyIndexEvent) {
        selectedCompany = event.companyEnitity;
        selectedUnit = event.unitEntity;
        selectedProductTypeEntity = event.productTypeEntity;

        emit(AddProductsInitial(
          companyEntity: event.companyEnitity,
          unitEntity: event.unitEntity,
          barCode: barCode,
          productTypeEntity: event.productTypeEntity,
          // controller: controller
        ));
      }
      if (event is AddProductEvent) {
        emit((const AddProductLoadingState()));
        var addResponse = await addProductsUsecase(event.productEntity);
        addResponse.fold((l) => mapFailureToMessage(l), (r) async {
          // emit(AddProductSuccessState());
          emit(AddProductsInitial(
              // controller: controller,
              companyEntity: selectedCompany,
              productTypeEntity: selectedProductTypeEntity,
              unitEntity: selectedUnit,
              barCode: barCode));
        });

        // add(GetProductsEvent());
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
