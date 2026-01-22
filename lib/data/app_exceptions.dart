
class AppExceptions implements Exception{

  final _message;
  final _prefix;

  AppExceptions(this._message, this._prefix);

  @override
  String toString() {
    return 'message: $_message\n{$_prefix}';
  }
}

class FatchDataExecption extends AppExceptions{
  FatchDataExecption([String ?  message]): super(message,"Error During Communication");
}

class BadRequestExecption extends AppExceptions{
  BadRequestExecption([String? message]): super(message,"Invalid request");
}