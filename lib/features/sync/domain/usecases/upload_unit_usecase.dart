import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/sync/domain/repositories/sync_repo.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';

class UploadUnitsUsecase {
  SyncRepo repo;
  UploadUnitsUsecase({required this.repo});
  Future<Either<Failure, bool>> call(List<Units> units) async {
    return await repo.uploadUnits(units: units);
  }
}
