part of 'sync_bloc.dart';

abstract class SyncState extends Equatable {
  const SyncState();

  @override
  List<Object> get props => [];
}

class SyncInitial extends SyncState {}

class SyncLoadingState extends SyncState {
  final String message;
  const SyncLoadingState({required this.message});
  @override
  List<Object> get props => [message];
}

class SyncSuccess extends SyncState {
  final String message;
  const SyncSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class NoInternetState extends SyncState {}

class SyncErrorState extends SyncState {
  final String m;
  const SyncErrorState({
    required this.m,
  });
  @override
  List<Object> get props => [m];
}
