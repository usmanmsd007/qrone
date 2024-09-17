import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/usecases/get_company_usecase.dart';
import 'package:qrone/features/product_types/domain/usecases/get_product_type_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/get_un_synced_products_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/upload_companies_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/upload_product_types_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/upload_product_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/upload_unit_usecase.dart';
import 'package:qrone/features/units/domain/usecases/get_unit_usecase.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  UploadCompaniesUsecase uploadCompaniesUsecase;
  UploadUnitsUsecase uploadUnitsUsecase;
  UploadProductTypesUsecase uploadProductTypesUsecase;
  UploadProductsUsecase uploadProductsUsecase;
  GetCompanyUsecase getCompanyUsecase;
  GetProductTypeUsecase getProductTypeUsecase;
  GetUnSyncedProductsUsecase getProductsUsecase;
  GetUnitUsecase getUnitUsecase;

  SyncBloc({
    required this.getCompanyUsecase,
    required this.uploadProductTypesUsecase,
    required this.uploadUnitsUsecase,
    required this.uploadCompaniesUsecase,
    required this.uploadProductsUsecase,
    required this.getUnitUsecase,
    required this.getProductTypeUsecase,
    required this.getProductsUsecase,
  }) : super(SyncInitial()) {
    on<SyncEvent>((event, emit) async {
      if (event is UploadDataEvent) {
        emit(const SyncLoadingState(message: "Syncing Companies"));
        var companiesResponse = await getCompanyUsecase();
        var a = await uploadCompaniesUsecase(
            companiesResponse.fold((error) => [], (r) => r));
        emit(a.fold((e) => SyncErrorState(m: mapFailureToMessage(e)),
            (ee) => const SyncSuccess(message: "Companies has been synced")));

        emit(const SyncLoadingState(message: "Syncing Units"));
        var failureOrUnits = await getUnitUsecase();
        var units = await uploadUnitsUsecase(
            failureOrUnits.fold((failure) => [], (r) => r));
        emit(units.fold((e) => SyncErrorState(m: mapFailureToMessage(e)),
            (ee) => const SyncSuccess(message: "Units has been synced")));

        emit(const SyncLoadingState(message: "Syncing Product Types"));
        var failureOrProductTypes = await getProductTypeUsecase();
        var productTypes = await uploadProductTypesUsecase(
            failureOrProductTypes.fold((failure) => [], (r) => r));
        emit(productTypes.fold(
            (e) => SyncErrorState(m: mapFailureToMessage(e)),
            (ee) =>
                const SyncSuccess(message: "Product Types has been synced")));

        emit(const SyncLoadingState(message: "Syncing Products"));
        var failureOrProducts = await getProductsUsecase();
        var products = await uploadProductsUsecase(
            failureOrProducts.fold((failure) => [], (r) => r));
        emit(products.fold((e) => SyncErrorState(m: mapFailureToMessage(e)),
            (ee) => const SyncSuccess(message: "Product has been synced")));
      }
    });
  }

  String mapFailureToMessage(Failure failure) {
    print(failure.toString());
    switch (failure.runtimeType) {
      case (EmptyListFailure):
        return "Sorry You don't have any products now. Please add some products";
      case (OtherListFailure):
        return "Sorry there was an error fetching the companies from database. Please try again";
      default:
        return "Unexpected Error , Please try again later.";
    }
  }
}
