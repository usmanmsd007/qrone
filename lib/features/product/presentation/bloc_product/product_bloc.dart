import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/companies/domain/usecases/get_company_usecase.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/usecases/get_products_usecase.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/product_types/domain/usecases/get_product_type_usecase.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/features/units/domain/usecases/get_unit_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  GetUnitUsecase unitUsecase;
  GetCompanyUsecase getCompanyUsecase;
  GetProductTypeUsecase getProductTypeUsecase;
  GetProductsUsecase getProducts;
  List<CompanyEntity> companies = [];
  List<ProductEntity> products = [];
  List<ProductTypeEntity> productTypes = [];
  List<Units> units = [];

  CompanyEntity? selectedCompany;
  ProductTypeEntity? selectedProductTypeEntity;
  Units? selectedUnit;
  String barCode = "";

  ProductBloc(
      {required this.getProductTypeUsecase,
      required this.getCompanyUsecase,
      required this.unitUsecase,
      required this.getProducts})
      : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is MoveToNextScreen) {
        print('object');
        emit(NextScreenState(
            productTypes: productTypes, companies: companies, units: units));
      }
      if (event is SearchProductKeywordEvent) {
        if (event.keyWord.isNotEmpty) {
          emit(SearchProductKeywordState(
              keyword: event.keyWord,
              products: products
                  .where((p) =>
                      p.name.contains(event.keyWord) ||
                      // p.companyName.contains(event.keyWord) ||
                      p.typeName.contains(event.keyWord))
                  .toList()));
        } else {
          emit(SearchProductKeywordState(keyword: event.keyWord, products: []));
        }
      }
      if (event is CloseSearchBarEvent) {
        emit(GetProductSuccessState(
            products: products,
            productTypes: productTypes,
            companies: companies,
            units: units));
      }
      if (event is GetProductsEvent) {
        emit(ProductsLoadingState());
        var productResponse = await getProducts();
        // emit(mapListResponseToState(response));
        var unitsResponse = await unitUsecase();
        var companyResponse = await getCompanyUsecase();
        var productTypeResponse = await getProductTypeUsecase();
        List<Units> units = unitsResponse.fold((u) {
          emit(ProductErrorState(
              e: "Sorry! No Units found. Please add some units"));
          return [];
        }, (units) {
          if (this.units.isEmpty) {
            this.units = units;
          }
          return units;
        });

        List<CompanyEntity> companies = companyResponse.fold((c) {
          emit(ProductErrorState(
              e: "Sorry! No Companies found. Please add some companies"));
          return [];
        }, (company) {
          if (this.companies.isEmpty) {
            this.companies = company;
          }
          return company;
        });

        List<ProductTypeEntity> productTypes = productTypeResponse.fold((c) {
          emit(ProductErrorState(
              e: "Sorry! No Types found. Please add some types"));
          return [];
        }, (productTypes) {
          if (this.productTypes.isEmpty) {
            this.productTypes = productTypes;
          }
          return productTypes;
        });

        productResponse.fold(
            (failure) => emit(ProductErrorState(
                  e: mapFailureToMessage(failure),
                )), (products) async {
          if (this.products.isEmpty) {
            this.products.addAll(products);
          }
          emit(GetProductSuccessState(
              productTypes: productTypes,
              products: products,
              companies: companies,
              units: units));
        });
      }
    });
  }

  String mapFailureToMessage(Failure failure) {
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
