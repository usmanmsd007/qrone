import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/product_types/domain/repositories/product_type_repository.dart';

class GetProductTypeUsecase {
  ProductTypeRepository repo;
  GetProductTypeUsecase({required this.repo});
  Future<Either<Failure, List<ProductTypeEntity>>> call() async {
    return await repo.getProductTypes();
  }
}
