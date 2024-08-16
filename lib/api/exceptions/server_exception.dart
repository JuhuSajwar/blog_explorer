import 'package:blog_explorer/api/base/base_exceptions.dart';


class ServerException extends BaseException {
  ServerException([int? code, String? message])
      : super(code, "Server error : $message");
}