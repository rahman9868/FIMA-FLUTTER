import 'dart:convert';

AuthTokens authTokensFromJson(String str) => AuthTokens.fromJson(json.decode(str));

String authTokensToJson(AuthTokens data) => json.encode(data.toJson());

class AuthTokens {
  final String accessToken;
  final String refreshToken;

  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokens.fromRawJson(String str) =>
      AuthTokens.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthTokens.fromJson(Map<String, dynamic> json) => AuthTokens(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
