import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/repositories/product_repo.dart';

class UpdateProductUsecase{
    ProductRepo repo;
  UpdateProductUsecase({required this.repo});
  Future<Either<Failure, ProductEntity>> call(ProductEntity product) async {
    return await repo.updateProduct(product);
  }
}