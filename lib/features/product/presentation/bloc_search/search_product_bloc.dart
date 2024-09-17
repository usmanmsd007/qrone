import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/usecases/search_product_usecase.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  SearchProductsUsecase searchProduct;
  List<CompanyEntity> companies = [];
  List<Units> units = [];
  List<ProductTypeEntity> types = [];
  SearchProductBloc({required this.searchProduct})
      : super(SearchProductInitial()) {
    on<SearchProductEvent>((event, emit) async {
      if (event is SearchByBarCode) {
        if (companies.isEmpty || units.isEmpty || types.isEmpty) {
          companies = event.companies;
          units = event.units;
          types = event.types;
        }

        var searchResult = await searchProduct(event.barCode);

        searchResult.fold(
            (failure) => emit(SearchProductErrorState(
                  message: mapFailureToMessage(failure),
                )), (products) async {
          emit(SearchProductSuccessState(result: products));
        });
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

  CompanyEntity getCompanyById(int id) {
    return companies.firstWhere((c) => c.id == id);
  }

  ProductTypeEntity getProductTypeEntityById(int id) {
    return types.firstWhere((c) => c.id == id);
  }

  Units getUnitById(int id) {
    return units.firstWhere((c) => c.id == id);
  }
}
