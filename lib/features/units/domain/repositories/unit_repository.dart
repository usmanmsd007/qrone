import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';

abstract class UnitRepository {
  Future<Either<Failure, List<Units>>> getUnits();
  Future<Either<Failure, Units>> addUnit(Units unit);
  Future<Either<Failure, Units>> updateUnit(Units unit);
}
