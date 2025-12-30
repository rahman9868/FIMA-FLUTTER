import 'package:meta/meta.dart';
import 'dart:convert';

AuthenticationTokens authenticationTokensFromJson(String str) => AuthenticationTokens.fromJson(json.decode(str));

String authenticationTokensToJson(AuthenticationTokens data) => json.encode(data.toJson());

class AuthenticationTokens {
    final String accessToken;
    final String refreshToken;

    AuthenticationTokens({
        required this.accessToken,
        required this.refreshToken,
    });

    factory AuthenticationTokens.fromJson(Map<String, dynamic> json) => AuthenticationTokens(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
    };
}
