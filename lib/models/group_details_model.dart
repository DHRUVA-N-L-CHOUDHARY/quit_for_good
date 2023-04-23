class GroupDetailsModel {
  String? admin;
  String? groupIcon;
  String? groupId;
  String? groupName;
  String? recentMessage;
  String? recentMessageSender;
  List<String>? members;
  GroupDetailsModel(
      {this.admin,
      this.groupIcon,
      this.groupId,
      this.groupName,
      this.recentMessage,
      this.recentMessageSender,
      this.members});

  GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    admin = json["admin"];
    groupIcon = json["groupIcon"];
    groupId = json["groupId"];
    groupName = json["groupName"];
    recentMessage = json["recentMessage"];
    recentMessageSender = json["recentMessageSender"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["admin"] = this.admin;
    data["groupIcon"] = this.groupIcon;
    data["groupId"] = this.groupId;
    data["groupName"] = this.groupName;
    data["recentMessage"] = this.recentMessage;
    data["recentMessageSender"] = this.recentMessageSender;
    data["members"] = this.members as List<String>;
    return data;
  }
}
