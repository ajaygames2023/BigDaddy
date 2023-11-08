class PanData {
  int? userId;
  String? name;
  String? state;
  String? panNumber;
  String? panCardFrontimage;
  String? panCardBackimage;
  String? status;
  // Null? remarks;
  // Null? idfyRequestId;
  // Null? idfyStatus;
  String? createdAt;
  String? updatedAt;

  PanData(
      {this.userId,
      this.name,
      this.state,
      this.panNumber,
      this.panCardFrontimage,
      this.panCardBackimage,
      this.status,
      // this.remarks,
      // this.idfyRequestId,
      // this.idfyStatus,
      this.createdAt,
      this.updatedAt});

  PanData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    state = json['state'];
    panNumber = json['panNumber'].toString();
    panCardFrontimage = json['panCardFrontimage'];
    panCardBackimage = json['panCardBackimage'];
    status = json['status'];
    // remarks = json['remarks'];
    // idfyRequestId = json['idfyRequestId'];
    // idfyStatus = json['idfyStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}