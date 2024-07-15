class CodeMsg {
  late int code;
  late String msg;
  CodeMsg(int code, String msg) {
    this.code = code;
    this.msg = msg;
  }
}

abstract class Result<T> {
  bool isOk();
  bool isErr();
  T? get();
  T getOr(T data);
  T getElse(T Function() fn);
  CodeMsg? getErr();
  Result<T> map(void Function(T data) fn);
  Result<T> errMap(void Function(CodeMsg err) fn);
}

class ResOk<T> implements Result<T> {
  final T t;

  ResOk(this.t);

  @override
  bool isOk() => true;

  @override
  bool isErr() => false;

  @override
  T? get() => t;

  @override
  T getOr(T data) => t;

  @override
  T getElse(T Function() fn) => t;

  @override
  CodeMsg? getErr() => null;

  @override
  Result<T> map(void Function(T data) fn) {
    fn(t);
    return this;
  }

  @override
  Result<T> errMap(void Function(CodeMsg err) fn) => this;
}

class ResErr<T> implements Result<T> {
  final CodeMsg err;

  ResErr(this.err);

  @override
  bool isOk() => false;

  @override
  bool isErr() => true;

  @override
  T? get() => null;

  @override
  T getOr(T data) => data;

  @override
  T getElse(T Function() fn) => fn();

  @override
  CodeMsg? getErr() => err;

  @override
  Result<T> map(void Function(T data) fn) => this;

  @override
  Result<T> errMap(void Function(CodeMsg err) fn) {
    fn(err);
    return this;
  }
}
