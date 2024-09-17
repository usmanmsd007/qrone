import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final int id;
  final String companyName;
  const CompanyEntity({this.id = -1, required this.companyName});
  CompanyEntity copyWith({int? id, String? unit}) {
    return CompanyEntity(
      id: id ?? this.id,
      companyName: unit ?? this.companyName,
    );
  }

  @override
  List<Object?> get props => [id, companyName];
}
