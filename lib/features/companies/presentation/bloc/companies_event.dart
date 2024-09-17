part of 'companies_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class InsertCompanyEvent extends CompanyEvent {
  final CompanyEntity unit;
  const InsertCompanyEvent({required this.unit});
}

class GetCompanyEvent extends CompanyEvent {
  GetCompanyEvent();
}
