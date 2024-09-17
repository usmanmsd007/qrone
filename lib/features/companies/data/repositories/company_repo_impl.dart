import 'package:dartz/dartz.dart';
import 'package:qrone/core/errors.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/data/datasources/company_local_datasource.dart';
import 'package:qrone/features/companies/data/models/company_model.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/companies/domain/repositories/company_repository.dart';

typedef DeleteOrUpdateOrAddPost = Future<CompanyEntity> Function();

class CompanyRepositoryImplem implements CompanyRepository {
  CompanyLocalDataSource localDataSourcel;

  CompanyRepositoryImplem({
    required this.localDataSourcel,
  });

  @override
  Future<Either<Failure, CompanyEntity>> addCompany(CompanyEntity unit) async {
    try {
      var id = await localDataSourcel
          .insertTodatabase(CompanyModel(companyName: unit.companyName));
      return Right(unit.copyWith(id: id));
    } on InsertException {
      return Left(InsertDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompanies() async {
    try {
      var companies = await localDataSourcel.getCompanysModels();
      return Right(companies);
    } on EmptyListException {
      return Left(EmptyListFailure());
    } on OtherListException {
      return Left(OtherListFailure());
    }
  }
}
