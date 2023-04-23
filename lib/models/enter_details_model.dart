class EnterDetailsModel {
  String? name;
  String? img;
  String? age;
  String? priceofpacket;
  String? smkprd;
  String? qtdate;
  String? mvt;

  EnterDetailsModel(
      {
      this.name,
      this.img,
      this.mvt,
      this.age,
      this.priceofpacket,
      this.smkprd,
      this.qtdate
      });

  EnterDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    img = json["img"];
    mvt = json["mvt"];
    age = json["age"];
    qtdate = json["qtdate"];
    smkprd = json["smkprd"];
    priceofpacket = json["priceofpacket"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["img"] = this.img;
    data["mvt"] = this.mvt;
    data["age"] = this.age;
    data["qtdate"] = this.qtdate;
    data["smkprd"] = this.smkprd;
    data["pricketofpacket"] = this.priceofpacket;
    return data;
  }
}
