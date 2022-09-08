import 'dart:convert';

PayReq payReqFromJson(String str) => PayReq.fromJson(json.decode(str));

String payReqToJson(PayReq data) => json.encode(data.toJson());

class PayReq {
  PayReq({
    this.status,
    this.authority,
    this.url,
  });

  dynamic status;
  dynamic authority;
  dynamic url;

  factory PayReq.fromJson(Map<String, dynamic> json) => PayReq(
        status: json["code"],
        authority: json["authority"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "code": status,
        "authority": authority,
        "url": url,
      };
}
