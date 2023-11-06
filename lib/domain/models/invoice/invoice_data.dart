class InvoiceData {
  String? id;
  String? custId;
  String? userId;
  num? itemId;
  String? itemDescription;
  String? price;
  String? remarks;
  num? orderId;
  num? amountAfterDiscount;
  num? gSTAmount;
  num? sGSTAmount;
  num? cGSTAmount;
  String? amountPaid;
  String? totalAmount;
  num? discount;
  String? updatedAt;
  String? createdAt;

  InvoiceData(
      {this.id,
      this.custId,
      this.userId,
      this.itemId,
      this.itemDescription,
      this.price,
      this.remarks,
      this.orderId,
      this.amountAfterDiscount,
      this.gSTAmount,
      this.sGSTAmount,
      this.cGSTAmount,
      this.amountPaid,
      this.totalAmount,
      this.discount,
      this.updatedAt,
      this.createdAt});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    id = json['Id'].toString();
    custId = json['Cust_id'].toString();
    userId = json['User_id'].toString();
    itemId = json['Item_id'];
    itemDescription = json['Item_description'];
    price = json['Price'].toString();
    remarks = json['Remarks'];
    orderId = json['Order_id'];
    amountAfterDiscount = json['Amount_after_discount'];
    gSTAmount = json['GST_amount'];
    sGSTAmount = json['SGST_amount'];
    cGSTAmount = json['CGST_amount'];
    amountPaid = json['Amount_paid'].toString();
    totalAmount = json['Total_amount'].toString();
    discount = json['Discount'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }
}