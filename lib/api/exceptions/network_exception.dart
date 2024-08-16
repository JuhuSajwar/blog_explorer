import 'package:blog_explorer/api/base/base_exceptions.dart';


class NetworkException extends BaseException {
  NetworkException()
      : super(null,
            "No internet found \n check you internet connection and try again");
}