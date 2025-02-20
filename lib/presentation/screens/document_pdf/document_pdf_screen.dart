import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

enum UserType{investor,company}
class DocumentPdfScreen extends StatelessWidget {
  final String pdf;
  final UserType userType;

  const DocumentPdfScreen({super.key,required this.pdf,required this.userType});

  @override
  Widget build(BuildContext context) {
    String pdfUrl = userType == UserType.company ? 'https://admin.ethabah.com/request_document' : 'https://admin.ethabah.com/investorFund/documents';
    return Scaffold(
        body: Container(
          child: PDF(
            fitPolicy: FitPolicy.BOTH
            // swipeHorizontal: true,
          ).cachedFromUrl('$pdfUrl/$pdf'),
        ));
  }
}


