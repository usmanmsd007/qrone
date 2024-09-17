import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/repositories/product_repo.dart';

class GetProductsUsecase {
  ProductRepo repo;
  GetProductsUsecase({required this.repo});
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repo.getProducts();
  }
}
