// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseModel {
  ResponseModel(this._isSuccess, this._message);
  bool _isSuccess;
  String _message;
  String get message => _message;
  bool get isSuccess => _isSuccess;
}
