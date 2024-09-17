import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/sync/domain/repositories/sync_repo.dart';

class UploadProductsUsecase {
  SyncRepo repo;
  UploadProductsUsecase({required this.repo});
  Future<Either<Failure, bool>> call(List<ProductEntity> products) async {
    return await repo.uploadProducts(products: products);
  }
}
