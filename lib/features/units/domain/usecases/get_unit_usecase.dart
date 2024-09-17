import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/features/units/domain/repositories/unit_repository.dart';

class GetUnitUsecase {
  UnitRepository repo;
  GetUnitUsecase({required this.repo});
  Future<Either<Failure, List<Units>>> call() async {
    return await repo.getUnits();
  }
}
