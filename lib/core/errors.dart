class ServerException implements Exception {}

class OfflineException implements Exception {}

class EmptyCacheException implements Exception {}

class InsertException implements Exception {
  String message;
  InsertException({required this.message});
}


class UpdateException implements Exception {
  String message;
  UpdateException({required this.message});
}

class EmptyListException implements Exception {
  EmptyListException();
}

class OtherListException implements Exception {
  OtherListException();
}

class DataNotUploadedException implements Exception {
  DataNotUploadedException();
}
