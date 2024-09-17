import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/companies/domain/repositories/company_repository.dart';

class GetCompanyUsecase {
  CompanyRepository repo;
  GetCompanyUsecase({required this.repo});
  Future<Either<Failure, List<CompanyEntity>>> call() async {
    return await repo.getCompanies();
  }
}
