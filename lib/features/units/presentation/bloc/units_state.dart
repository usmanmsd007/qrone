part of 'units_bloc.dart';

abstract class UnitsState extends Equatable {
  const UnitsState();

  @override
  List<Object> get props => [];
}

class UnitsInitial extends UnitsState {}

class UnitLoadingState extends UnitsState {}

class UnitsSuccesssState extends UnitsState {
  final List<Units> m;
  const UnitsSuccesssState({required this.m});
}

class UnitsDeleteSuccesssState extends UnitsState {
  const UnitsDeleteSuccesssState();
}

class UnitErrorState extends UnitsState {
  final String e;
  const UnitErrorState({
    required this.e,
  });
}

class UnitDeleteErrorState extends UnitsState {
  final String e;
  const UnitDeleteErrorState({
    required this.e,
  });
}
