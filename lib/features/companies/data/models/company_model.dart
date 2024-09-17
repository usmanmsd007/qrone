import 'package:qrone/features/companies/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  CompanyModel({super.id, required super.companyName});
  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
    };
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] as int,
      companyName: json['company_name'],
    );
  }
}
