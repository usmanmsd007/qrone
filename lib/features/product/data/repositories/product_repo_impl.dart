import 'package:dartz/dartz.dart';
import 'package:qrone/core/errors.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product/data/datasources/product_local_data_source.dart';
import 'package:qrone/features/product/data/models/product_model.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/domain/repositories/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  ProductLocalDataSource localDataSource;
  ProductRepoImpl({required this.localDataSource});
  @override
  Future<Either<Failure, ProductEntity>> addProducts(
      ProductEntity product) async {
    try {
      var id = await localDataSource.insertProcutTodatabase(ProductModel(
        unitName: product.unitName,
        companyName: product.companyName,
        typeName: product.typeName,
        isSynced: false,
        productTypeId: product.productTypeId,
        code: product.code,
        lastUpdated: product.lastUpdated,
        name: product.name,
        id: product.id,
        price: product.price,
        isDeleted: product.isDeleted,
        companyId: product.companyId,
        unitId: product.unitId,
      ));
      return Right(product.copyWith(id: id));
    } on InsertException {
      return Left(InsertDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      var products = await localDataSource.getProductModels();
      return Right(products);
    } on EmptyListException {
      return Left(EmptyListFailure());
    } on OtherListException {
      return Left(OtherListFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
      String code) async {
    try {
      var products = await localDataSource.searchProductModels(code);
      return Right(products);
    } on EmptyListException {
      return Left(EmptyListFailure());
    } on OtherListException {
      return Left(OtherListFailure());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
      ProductEntity product) async {
    try {
      var id = await localDataSource.updateProduct(ProductModel(
        unitName: product.unitName,
        companyName: product.companyName,
        typeName: product.typeName,
        isSynced: false,
        productTypeId: product.productTypeId,
        code: product.code,
        lastUpdated: product.lastUpdated,
        name: product.name,
        id: product.id,
        price: product.price,
        isDeleted: product.isDeleted,
        companyId: product.companyId,
        unitId: product.unitId,
      ));
      return Right(product.copyWith(id: id));
    } on InsertException {
      return Left(UpdateProductFailure());
    }
  }
}
