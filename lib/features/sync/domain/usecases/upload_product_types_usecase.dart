import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/sync/domain/repositories/sync_repo.dart';

class UploadProductTypesUsecase {
  SyncRepo repo;
  UploadProductTypesUsecase({required this.repo});
  Future<Either<Failure, bool>> call(List<ProductTypeEntity> types) async {
    return await repo.uploadTypes(type: types);
  }
}
