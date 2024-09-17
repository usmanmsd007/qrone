part of 'units_bloc.dart';

abstract class UnitsEvent extends Equatable {
  const UnitsEvent();

  @override
  List<Object> get props => [];
}

class InsertUnitEvent extends UnitsEvent {
  final Units unit;
  const InsertUnitEvent({required this.unit});
}

class GetUnitsEvent extends UnitsEvent {
  GetUnitsEvent();
}

class DeleteUnitsEvent extends UnitsEvent {
  final Units unit;
  const DeleteUnitsEvent({required this.unit});
}
