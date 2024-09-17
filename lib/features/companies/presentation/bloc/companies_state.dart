part of 'companies_bloc.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

class CompanyInitial extends CompanyState {}

class CompanyLoadingState extends CompanyState {}

class CompanyScueessState extends CompanyState {
  final List<CompanyEntity> companies;
  const CompanyScueessState({required this.companies});
}

class CompanyErrorState extends CompanyState {
  final String e;
  const CompanyErrorState({
    required this.e,
  });
}
