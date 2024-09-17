import 'package:dartz/dartz.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';

import '../../../../core/exceptions.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String code);
  Future<Either<Failure, ProductEntity>> addProducts(ProductEntity product);
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);
}
