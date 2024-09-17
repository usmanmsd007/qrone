import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';

abstract class ProductTypeRepository {
  Future<Either<Failure, List<ProductTypeEntity>>> getProductTypes();
  Future<Either<Failure, ProductTypeEntity>> addProductType(
      ProductTypeEntity productType);
  Future<Either<Failure, ProductTypeEntity>> updateProductType(
      ProductTypeEntity productType);
}
