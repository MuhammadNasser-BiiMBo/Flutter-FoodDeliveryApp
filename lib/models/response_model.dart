class ResponseModel{
  bool _isSuccess;
  String _message;
  String get message =>_message;
  bool get isSuccess =>_isSuccess;
  ResponseModel(this._isSuccess, this._message);

}