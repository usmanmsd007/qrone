import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/repositories/product_repo.dart';

class AddProductsUsecase {
  ProductRepo repo;
  AddProductsUsecase({required this.repo});
  Future<Either<Failure, ProductEntity>> call(ProductEntity p) async {
    return await repo.addProducts(p);
  }
}
