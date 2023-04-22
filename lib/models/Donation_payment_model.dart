class DonationPaymentModel {
  String? ngoname;
  String? typeofpayment;
  String? amttrfs;
  String? time;
  String? totalamttrs;
  String? trsid;

  DonationPaymentModel(
      {this.ngoname,
      this.typeofpayment,
      this.amttrfs,
      this.time,
      this.totalamttrs,
      this.trsid});

  DonationPaymentModel.fromJson(Map<String, dynamic> json) {
    ngoname = json['ngoname'];
    typeofpayment = json['typeofpayment'];
    amttrfs = json["amttrfs"];
    time = json["time"];
    totalamttrs = json["totalamttrs"];
    trsid = json["trsid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ngoname'] = this.ngoname;
    data['typeofpayment'] = this.typeofpayment;
    data["amttrfs"] = this.amttrfs;
    data["time"] = this.time;
    data["totalamttrs"] = this.totalamttrs;
    data["trsid"] = this.trsid;
    return data;
  }
}
