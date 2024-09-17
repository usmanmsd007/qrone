import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/features/units/domain/repositories/unit_repository.dart';

class InsertUnitUsecase {
  UnitRepository repo;
  InsertUnitUsecase({required this.repo});
  Future<Either<Failure, Units>> call(Units unit) async {
    return await repo.addUnit(unit);
  }
}