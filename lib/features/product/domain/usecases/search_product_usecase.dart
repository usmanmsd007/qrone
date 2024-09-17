import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/repositories/product_repo.dart';

class SearchProductsUsecase {
  ProductRepo repo;
  SearchProductsUsecase({required this.repo});
  Future<Either<Failure, List<ProductEntity>>> call(String code) async {
    return await repo.searchProducts(code);
  }
}
