class DoctorDetailsModel {
  String? name;
  String? img;
  String? descri;

  DoctorDetailsModel(
      {
      this.name,
      this.img,
      this.descri,
      });

  DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    img = json["img"];
    descri = json["descri"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["img"] = this.img;
    data["descri"] = this.descri;
    return data;
  }
}
