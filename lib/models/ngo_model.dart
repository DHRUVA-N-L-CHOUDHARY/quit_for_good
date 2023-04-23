class NgodetailsModel {
  String? name;
  String? logo;
  String? description;

  NgodetailsModel(
      {
      this.name,
      this.logo,
      this.description,
      });

  NgodetailsModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    logo = json["logo"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["logo"] = this.logo;
    data["description"] = this.description;
    return data;
  }
}
