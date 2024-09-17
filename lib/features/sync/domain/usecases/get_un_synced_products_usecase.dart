import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/sync/domain/repositories/sync_repo.dart';

class GetUnSyncedProductsUsecase {
  SyncRepo repo;
  GetUnSyncedProductsUsecase({required this.repo});
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repo.getUnSyncedProducts();
  }
}
