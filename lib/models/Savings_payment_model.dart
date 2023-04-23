class SavingsPaymentModel {
  String? amttrfs;
  String? time;
  String? totalamttrs;
  String? trsid;

  SavingsPaymentModel(
      {
      this.amttrfs,
      this.time,
      this.totalamttrs,
      this.trsid});

  SavingsPaymentModel.fromJson(Map<String, dynamic> json) {
    amttrfs = json["amttrfs"];
    time = json["time"];
    totalamttrs = json["totalamttrs"];
    trsid = json["trsid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["amttrfs"] = this.amttrfs;
    data["time"] = this.time;
    data["totalamttrs"] = this.totalamttrs;
    data["trsid"] = this.trsid;
    return data;
  }
}
