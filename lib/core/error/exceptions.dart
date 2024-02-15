

import 'package:currency/core/error/failure.dart';
import 'package:currency/core/network/error_message_model.dart';

class ServerExceptions implements Exception {
  final ErrorMessageModel errorMessageModel;
  ServerExceptions({
    required this.errorMessageModel,
  });
}

// if worke with local data source
class LocalDataBaseException implements Exception {
  final ErrorMessageModel errorMessageModel;
  LocalDataBaseException({
    required this.errorMessageModel,
  });
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class DataBaseFailure extends Failure {
  const DataBaseFailure(super.message);
}
