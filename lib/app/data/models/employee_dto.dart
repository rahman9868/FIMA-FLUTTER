import 'dart:convert';

import 'account_dto.dart';

EmployeeDto employeeDtoFromJson(String str) =>
    EmployeeDto.fromJson(json.decode(str));

String employeeDtoToJson(EmployeeDto data) => json.encode(data.toJson());

class EmployeeDto {
  final int id;
  final bool? isVip;
  final bool? vipIn;
  final bool? vipOut;
  final AccountDto account;
  final bool? employeeActive;
  final bool? employeeExt;
  final String? modified;
  final String? lastSync;
  final String? syncSource;
  final String? status;
  final bool? useKeycloak;
  final String? lastUpdate;

  EmployeeDto({
    required this.id,
    required this.isVip,
    required this.vipIn,
    required this.vipOut,
    required this.account,
    required this.employeeActive,
    required this.employeeExt,
    required this.modified,
    required this.lastSync,
    required this.syncSource,
    required this.status,
    required this.useKeycloak,
    this.lastUpdate,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) => EmployeeDto(
        id: json["id"],
        isVip: json["isVip"],
        vipIn: json["vipIn"],
        vipOut: json["vipOut"],
        account: AccountDto.fromJson(json["account"]),
        employeeActive: json["employeeActive"],
        employeeExt: json["employeeExt"],
        modified: json["modified"],
        lastSync: json["lastSync"],
        syncSource: json["syncSource"],
        status: json["status"],
        useKeycloak: json["useKeycloak"],
        lastUpdate: json["lastUpdate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isVip": isVip,
        "vipIn": vipIn,
        "vipOut": vipOut,
        "account": account.toJson(),
        "employeeActive": employeeActive,
        "employeeExt": employeeExt,
        "modified": modified,
        "lastSync": lastSync,
        "syncSource": syncSource,
        "status": status,
        "useKeycloak": useKeycloak,
        "lastUpdate": lastUpdate,
      };
}
