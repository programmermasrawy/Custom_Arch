import 'response_model.dart';

class MessageResponse extends ResponseModel {
  MessageResponse({
    required this.message,
    this.code,
  });

  factory MessageResponse.fromMap(Map<String, dynamic> map, {String? code}) =>
      MessageResponse(
        message: ((map['errors'] is String)
                ? map['errors'] as String?
                : map['errors']['message'] as String?) ??
            map['msg'] as String? ??
            '',
        code: map['code'],
      );

  final String message;
  final String? code;

  Map<String, dynamic> toMap() {
    return {
      'errors': message,
      'code': code,
    };
  }

  @override
  List<Object?> get props => [message, code];
}
