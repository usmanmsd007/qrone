import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/product_types/domain/usecases/get_product_type_usecase.dart';
import 'package:qrone/features/product_types/domain/usecases/insert_product_type_usecase.dart';

part 'product_type_event.dart';
part 'product_type_state.dart';

class ProductTypeBloc extends Bloc<ProductTypeEvent, ProductTypeState> {
  InsertProductTypeUsecase insertProductTypeUsecase;
  GetProductTypeUsecase getProductTypeUsecase;

  ProductTypeBloc(
      {required this.insertProductTypeUsecase,
      required this.getProductTypeUsecase})
      : super(ProductTypeInitial()) {
    on<ProductTypeEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is GetProductTypeEvent) {
        emit(ProductTypeLoadingState());
        var response = await getProductTypeUsecase();
        emit(mapListResponseToState(response));
      }
      if (event is InsertProductTypeEvent) {
        emit(ProductTypeLoadingState());
        await insertProductTypeUsecase(event.productType);

        this.add(GetProductTypeEvent());
      }
    });
  }

  handleState(ProductTypeEvent event, Emitter<ProductTypeState> emit) async {}

  ProductTypeState mapListResponseToState(
      Either<Failure, List<ProductTypeEntity>> either) {
    return either.fold(
        (failure) => ProductTypeErrorState(
              e: mapFailureToMessage(failure),
            ),
        (unit) => ProductTypeScueessState(m: unit));
  }

  String mapFailureToMessage(Failure failure) {
    print(failure.toString());
    switch (failure.runtimeType) {
      case (EmptyListFailure):
        return "Sorry You don't have any units now. Please add some units";
      case (OtherListFailure):
        return "Sorry there was an error fetching the units from database. Please try again";
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
