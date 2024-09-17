import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/companies/domain/repositories/company_repository.dart';

class InsertCompanyUsecase {
  CompanyRepository repo;
  InsertCompanyUsecase({required this.repo});
  Future<Either<Failure, CompanyEntity>> call(CompanyEntity company) async {
    return await repo.addCompany(company);
  }
}
