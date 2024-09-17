import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InsertDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class UpdateProductFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class DataNotUploadedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UpdateDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyListFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class OtherListFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoInternetFailure extends Failure {
  @override
  List<Object?> get props => [];
}
