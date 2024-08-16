import 'package:blog_explorer/api/base/base_exceptions.dart';


class Resource<T> {
  Status? status;
  T? data;
  BaseException? exception;

  Resource.loading() : status = Status.LOADING;
  Resource.success(this.data) : status = Status.SUCCESS;
  Resource.error(this.exception) : status = Status.ERROR;
}

enum Status { LOADING, SUCCESS, ERROR }