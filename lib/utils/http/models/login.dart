class LoginRequest {
  final String token; // Adjust based on actual API response
  final String pin;
  final String deviceId;

  LoginRequest({
    required this.token,
    required this.pin,
    required this.deviceId,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      token: json['token'], // Adjust based on actual API response
      pin: json['pin'],
      deviceId: json['device_id'],
    );
  }

  Map<String, String> toMap() {
    return {
      'pin': pin,
      'device_id': deviceId,
    };
  }
}
