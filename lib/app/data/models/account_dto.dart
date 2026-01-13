import 'dart:convert';

AccountDto accountDtoFromJson(String str) =>
    AccountDto.fromJson(json.decode(str));

String accountDtoToJson(AccountDto data) => json.encode(data.toJson());

class AccountDto {
  final int id;
  final String? name;
  final String? phone;
  final String? picture;
  final String? timezone;
  final String? username;
  final String? email;
  final List<dynamic>
  accesses; // Assuming AccessDto is complex, handle as needed
  final List<dynamic> roles; // Assuming RoleDto is complex, handle as needed
  final String? created;
  final String? modified;

  AccountDto({
    required this.id,
    required this.name,
    required this.phone,
    required this.picture,
    required this.timezone,
    required this.username,
    required this.email,
    required this.accesses,
    required this.roles,
    required this.created,
    required this.modified,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) => AccountDto(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    picture: json["picture"],
    timezone: json["timezone"],
    username: json["username"],
    email: json["email"],
    accesses: List<dynamic>.from(json["accesses"].map((x) => x)),
    roles: List<dynamic>.from(json["roles"].map((x) => x)),
    created: json["created"],
    modified: json["modified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "picture": picture,
    "timezone": timezone,
    "username": username,
    "email": email,
    "accesses": List<dynamic>.from(accesses.map((x) => x)),
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "created": created,
    "modified": modified,
  };
}
