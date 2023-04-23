// To parse this JSON data, do
//
//     final CallRequest = CallRequestFromJson(jsonString);

import 'dart:convert';

CallRequest CallRequestFromJson(String str) =>
    CallRequest.fromJson(json.decode(str));

String CallRequestToJson(CallRequest data) => json.encode(data.toJson());

class CallRequest {
  CallRequest({
    required this.date,
    required this.description,
    required this.requestedby,
    required this.requestto,
    required this.status,
    required this.type,
    required this.cnt,
  });

  final String date;
  final String description;
  final String requestedby;
  final String requestto;
  final String status;
  final String type;
  final String cnt;

  factory CallRequest.fromJson(Map<String, dynamic> json) => CallRequest(
        date: json["date"],
        description: json["_description"],
        requestedby: json["requestedby"],
        status: json["status"],
        type: json["type"],
        requestto: json["requestto"],
        cnt:json["cnt"]
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "_description": description,
        "requestedby": requestedby,
        "status": status,
        "type": type,
        "requestto": requestto,
        "cnt":cnt
      };
}
