import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/companies/domain/usecases/get_company_usecase.dart';
import 'package:qrone/features/companies/domain/usecases/insert_company_usecase.dart';

part 'companies_event.dart';
part 'companies_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  InsertCompanyUsecase insertCompanyUsecase;
  GetCompanyUsecase getCompanyUsecase;

  CompanyBloc(
      {required this.insertCompanyUsecase, required this.getCompanyUsecase})
      : super(CompanyInitial()) {
    on<CompanyEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is GetCompanyEvent) {
        emit(CompanyLoadingState());
        var res = await getCompanyUsecase();
        emit(mapListResponseToState(res));
      }
      if (event is InsertCompanyEvent) {
        emit(CompanyLoadingState());

        await insertCompanyUsecase(event.unit);
        add(GetCompanyEvent());
      }
    });
  }

  CompanyState mapListResponseToState(
      Either<Failure, List<CompanyEntity>> either) {
    return either.fold(
        (failure) => CompanyErrorState(
              e: mapFailureToMessage(failure),
            ),
        (companies) => CompanyScueessState(companies: companies));
  }

  String mapFailureToMessage(Failure failure) {
    print(failure.toString());
    switch (failure.runtimeType) {
      case (EmptyListFailure):
        return "Sorry You don't have any companies now. Please add some companies";
      case (OtherListFailure):
        return "Sorry there was an error fetching the companies from database. Please try again";
      default:
        return "Unexpected Error , Please try again later.";
    }
  }
}
