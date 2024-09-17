import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/sync/domain/repositories/sync_repo.dart';

class UploadCompaniesUsecase {
  SyncRepo repo;
  UploadCompaniesUsecase({required this.repo});
  Future<Either<Failure, bool>> call(List<CompanyEntity> companies) async {
    return await repo.uploadCompanies(companyEntity: companies);
  }
}
