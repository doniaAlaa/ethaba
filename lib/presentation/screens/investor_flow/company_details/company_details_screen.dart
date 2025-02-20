import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ethabah/models/company_model.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/date_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/req_investment_fund_model.dart';

class CompanyDetailScreen extends StatelessWidget {
  final Company fcompany;
  const CompanyDetailScreen({required this.fcompany, super.key});

  @override
  Widget build(BuildContext context) {
    final company = fcompany;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          StringConstants.companyDetails,
          style:
              kSubtitleTextStyle.copyWith(color: kNeonColor, fontSize: 18.sp),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: kNeonColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              icon: Icons.business,
              label: StringConstants.name,
              value: company.name,
            ),
            _buildInfoCard(
              icon: Icons.confirmation_number,
              label: StringConstants.companyRegistrationNumber,
              value: company.registerNum,
            ),
            _buildInfoCard(
              icon: Icons.phone,
              label: StringConstants.phoneNumber,
              value: company.phone,
            ),
            _buildInfoCard(
              icon: Icons.email,
              label: StringConstants.email,
              value: company.email,
            ),
            if (company.address != null)
              _buildInfoCard(
                icon: Icons.location_on,
                label: StringConstants.address,
                value: company.address!,
              ),
            _buildDocumentSection(
              icon: Icons.picture_as_pdf,
              label: StringConstants.comericalCertificate,
              urls: company.registerCertificateUrls,
            ),
            _buildDocumentSection(
              icon: Icons.picture_as_pdf,
              label: StringConstants.passportOrIdOfTheOwner,
              urls: company.commercialCertificateUrls,
            ),
            if (company.licenses != null)
              _buildDocumentSection(
                icon: Icons.picture_as_pdf,
                label: StringConstants.licenses,
                urls: company.licensesUrls,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon, required String label, required String value}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Row(
          children: [
            Icon(icon, color: kPrimaryColor, size: 30.sp),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: ksmallDescTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    value,
                    style: ksmallDescTextStyle.copyWith(
                      fontSize: 18.sp,
                      color: kBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentSection(
      {required IconData icon,
      required String label,
      required List<String> urls}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: kPrimaryColor, size: 30.sp),
                SizedBox(width: 15.w),
                Flexible(
                  child: Text(
                    label,
                    style: ksmallDescTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 16.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: urls.map((url) => _buildUrlWidget(url)).toList(),
            ),
            SizedBox(height: 10.h),
            ElevatedButton.icon(
              onPressed: () => _downloadAllFiles(urls),
              icon: Icon(Icons.download),
              label: Text(StringConstants.downloadAll),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: kWhiteColor,
                textStyle: ksmallDescTextStyle.copyWith(
                  color: kWhiteColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUrlWidget(String url) {
    bool isPdf = url.toLowerCase().endsWith('.pdf');
    bool isImage = ['jpg', 'jpeg', 'png', 'gif', 'bmp']
        .any((ext) => url.toLowerCase().endsWith(ext));
    bool isDoc = ['doc', 'docx'].any((ext) => url.toLowerCase().endsWith(ext));

    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPdf
                  ? Icons.picture_as_pdf
                  : isImage
                      ? Icons.image
                      : isDoc
                          ? Icons.description
                          : Icons.insert_drive_file,
              color: kNeonColor,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                url.split('/').last,
                style: ksmallDescTextStyle.copyWith(
                  color: kWhiteColor,
                  fontSize: 16.sp,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _downloadAllFiles(List<String> urls) async {
    for (String url in urls) {
      await _launchURL(url);
    }
  }
}
