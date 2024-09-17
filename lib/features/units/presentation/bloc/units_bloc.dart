import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/features/units/domain/usecases/get_unit_usecase.dart';
import 'package:qrone/features/units/domain/usecases/insert_unit_usecase.dart';
import 'package:qrone/features/units/domain/usecases/update_unit_usecase.dart';

part 'units_event.dart';
part 'units_state.dart';

class UnitsBloc extends Bloc<UnitsEvent, UnitsState> {
  InsertUnitUsecase insertUnitUsecase;
  GetUnitUsecase getUnitUsecase;
  UpdateUnitUsecase updateUnitUsecase;

  UnitsBloc(
      {required this.updateUnitUsecase,
      required this.insertUnitUsecase,
      required this.getUnitUsecase})
      : super(UnitsInitial()) {
    on<UnitsEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is GetUnitsEvent) {
        emit(UnitLoadingState());
        var response = await getUnitUsecase();
        emit(mapListResponseToState(response));
      }
      if (event is InsertUnitEvent) {
        emit(UnitLoadingState());
        await insertUnitUsecase(event.unit);

        add(GetUnitsEvent());
      }
      if (event is DeleteUnitsEvent) {
        emit(UnitLoadingState());
        var deleteUnitResponse = await updateUnitUsecase(event.unit);
        emit(deleteUnitResponse.fold(
            (error) => UnitDeleteErrorState(e: error.toString()),
            (success) => const UnitsDeleteSuccesssState()));
        add(GetUnitsEvent());
      }
    });
  }

  handleState(UnitsEvent event, Emitter<UnitsState> emit) async {}

  UnitsState mapListResponseToState(Either<Failure, List<Units>> either) {
    return either.fold(
        (failure) => UnitErrorState(
              e: mapFailureToMessage(failure),
            ),
        (unit) => UnitsSuccesssState(m: unit));
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
