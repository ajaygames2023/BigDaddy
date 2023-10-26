import 'invoice_data.dart';

class GenerateInvoiceModel {
  InvoiceData? invoiceData;
  String? invoiceUrl;

  GenerateInvoiceModel({this.invoiceData, this.invoiceUrl});

  GenerateInvoiceModel.fromJson(Map<String, dynamic> json) {
    invoiceData = json['invoiceData'] != null
        ? InvoiceData.fromJson(json['invoiceData'])
        : null;
    invoiceUrl = json['invoice_url'];
  }
}

