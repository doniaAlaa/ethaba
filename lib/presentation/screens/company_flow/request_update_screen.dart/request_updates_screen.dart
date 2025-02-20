import 'dart:developer';
import 'dart:io';

import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/date_helper.dart';
import 'package:ethabah/data/remote/request_provider.dart';
import 'package:ethabah/models/categories_model.dart';
import 'package:ethabah/models/project_doc.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestUpdatesScreen extends StatefulWidget {
  const RequestUpdatesScreen({super.key});

  @override
  _RequestUpdatesScreenState createState() => _RequestUpdatesScreenState();
}

class _RequestUpdatesScreenState extends State<RequestUpdatesScreen> {
  RxBool isLoading = false.obs;
  final dropdownController = Get.isRegistered<CategoriesController>()
      ? Get.find<CategoriesController>()
      : Get.put(CategoriesController(), permanent: true);

  @override
  void initState() {
    super.initState();
    // dropdownController.loadProjectNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          StringConstants.projectUpdates,
          style: TextStyle(
            color: kNeonColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            fontFamily: kFontFamily,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kNeonColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  StringConstants.projectUpdates,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: kFontFamily,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              //Textfield title ("New Update")
              Text(
                StringConstants.newUpdate,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: kFontFamily,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: kTextFieldFillColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringConstants.uploadNewUpdate,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: kHintTextColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: kFontFamily,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                          context: context,
                          backgroundColor: kBackgroundColor,
                          isScrollControlled: true,
                          builder: (context) {
                            return addUpdateBottomSheetContent(context);
                          },
                        );
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: kNeonColor, size: 16.sp),
                            SizedBox(width: 5.w),
                            Text(
                              StringConstants.upload,
                              style: kHintTextStyle.copyWith(color: kNeonColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                StringConstants.recentUpdate,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: kFontFamily,
                ),
              ),
              // SizedBox(height: 10.h),
              // FutureBuilder(
              //     future: RequestProvider.getProjects(),
              //     builder: (context, snapshot) {
              //       log(snapshot.data.toString());
              //       if (ConnectionState.waiting == snapshot.connectionState) {
              //         return const Center(
              //           child: CircularProgressIndicator(color: kPrimaryColor),
              //         );
              //       }
              //       if (snapshot.data == null ||
              //           snapshot.data == [] ||
              //           snapshot.data!.isEmpty) {
              //         return SizedBox(
              //           height: 200, // Adjust the height as needed
              //           child: Center(
              //             child: Text(
              //               StringConstants.noProjectsUpdate,
              //               style: kHeadingTextStyle.copyWith(
              //                 color: kPrimaryColor,
              //                 fontSize: 16.sp,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ),
              //         );
              //       }
              //       // List<ProjectDocument> projects = snapshot.data!;
              //       // return ListView.builder(
              //       //     padding: EdgeInsets.zero,
              //       //     physics: const NeverScrollableScrollPhysics(),
              //       //     shrinkWrap: true,
              //       //     itemCount: projects!.length,
              //       //     itemBuilder: (context, index) {
              //       //       return Padding(
              //       //         padding: const EdgeInsets.symmetric(vertical: 10),
              //       //         child: Container(
              //       //           padding: const EdgeInsets.symmetric(
              //       //               horizontal: 10, vertical: 15),
              //       //           decoration: BoxDecoration(
              //       //             color: kSecondaryColor,
              //       //             borderRadius: BorderRadius.circular(10),
              //       //           ),
              //       //           child: Row(
              //       //             children: [
              //       //               Column(
              //       //                 crossAxisAlignment:
              //       //                     CrossAxisAlignment.start,
              //       //                 mainAxisAlignment: MainAxisAlignment.center,
              //       //                 children: [
              //       //                   Text(
              //       //                     projects[index].updateName,
              //       //                     style: kSubtitleTextStyle.copyWith(
              //       //                         fontWeight: FontWeight.bold,
              //       //                         color: kNeonColor,
              //       //                         fontSize: 14.sp),
              //       //                   ),
              //       //                   SizedBox(
              //       //                     height: 5.h,
              //       //                   ),
              //       //                   Text(
              //       //                     dropdownController.getProjectName(
              //       //                         int.parse(
              //       //                             projects[index].requestId)),
              //       //                     style: kSubtitleTextStyle.copyWith(
              //       //                         fontWeight: FontWeight.bold,
              //       //                         color: kWhiteColor,
              //       //                         fontSize: 14.sp),
              //       //                   ),
              //       //                   SizedBox(
              //       //                     height: 5.h,
              //       //                   ),
              //       //                   //updated date
              //       //                   Text(
              //       //                     "${StringConstants.lastUpdated} ${formatDate(projects[index].updatedAt.toString())}",
              //       //                     style: kSubtitleTextStyle.copyWith(
              //       //                         fontSize: 10.sp,
              //       //                         color: Colors.white),
              //       //                   ),
              //       //                 ],
              //       //               ),
              //       //               const Spacer(),
              //       //               Column(
              //       //                 mainAxisAlignment: MainAxisAlignment.center,
              //       //                 crossAxisAlignment:
              //       //                     CrossAxisAlignment.center,
              //       //                 children: [
              //       //                   InkWell(
              //       //                     onTap: () {
              //       //                       // _launchURL(Uri.parse(
              //       //                       //         projects[index].documentUrl)
              //       //                       //     .toString());
              //       //                       launchUrl(Uri.parse(
              //       //                           projects[index].documentUrl));
              //       //                     },
              //       //                     child: Container(
              //       //                       padding: EdgeInsets.symmetric(
              //       //                           horizontal: 10.w, vertical: 5.h),
              //       //                       decoration: BoxDecoration(
              //       //                         color: kPrimaryColor,
              //       //                         borderRadius:
              //       //                             BorderRadius.circular(5),
              //       //                       ),
              //       //                       child: Center(
              //       //                         child: Text(
              //       //                           StringConstants.download,
              //       //                           style: TextStyle(
              //       //                             color: kNeonColor,
              //       //                             fontSize: 12.sp,
              //       //                             fontWeight: FontWeight.bold,
              //       //                           ),
              //       //                         ),
              //       //                       ),
              //       //                     ),
              //       //                   )
              //       //                 ],
              //       //               )
              //       //             ],
              //       //           ),
              //       //         ),
              //       //       );
              //       //     });
              //     }),
            ],
          ),
        ),
      ),
    );
  }
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

Widget addUpdateBottomSheetContent(BuildContext context) {
  final TextEditingController nameOfUpdateController = TextEditingController();
  RxString errorNameOfUpdate = ''.obs;
  RxBool isLoading = false.obs;
  final Rx<String?> selectedCategory = Rx<String?>(null);
  RxString categoryError = ''.obs;

  // File pic, doc, pdf
  Map<int, String> project = {};
  List<String> projectName = [];
  final categoriesCntrlr = Get.isRegistered<CategoriesController>()
      ? Get.find<CategoriesController>()
      : Get.put(CategoriesController(), permanent: true);
  Rx<File?> selectedFile = Rx<File?>(null);
  RxString fileError = ''.obs;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  bool validate() {
    if (nameOfUpdateController.text.isEmpty) {
      errorNameOfUpdate.value = StringConstants.thisFieldIsRequired;
      return false;
    } else {
      errorNameOfUpdate.value = "";
    }

    if (selectedCategory.value == null) {
      categoryError.value = StringConstants.thisFieldIsRequired;
      return false;
    } else {
      categoryError.value = "";
    }

    if (selectedFile.value == null) {
      fileError.value = StringConstants.thisFieldIsRequired;
      return false;
    } else {
      fileError.value = "";
    }

    return true;
  }

  void uploadUpdate() async {
    isLoading.value = true;
    try {
      if (validate()) {
        final response = await RequestProvider.postProjectUpdate(
            nameOfUpdateController.text,
            project.keys
                .firstWhere((key) => project[key] == selectedCategory.value),
            selectedFile.value!);
        if (response) {
          isLoading.value = false;
          Get.back();
          Get.snackbar(
            StringConstants.success,
            StringConstants.updateUploadedSuccessfully,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        StringConstants.error,
        e.toString(),
        backgroundColor: Colors.red,
        colorText: kBlackColor,
      );
    }
  }

  project = categoriesCntrlr.projectNames;
  projectName = project.values.toList();

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 50.w,
              height: 5,
              decoration: BoxDecoration(
                color: kHintTextColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          // New Update
          Center(
            child: Text(
              StringConstants.newUpdate,
              style: TextStyle(
                fontSize: 16.sp,
                color: kPrimaryColor,
                fontWeight: FontWeight.w700,
                fontFamily: kFontFamily,
              ),
            ),
          ),
          // Name of the update
          CustomCompleteInputfield(
            textfiledTitle: Text(
              StringConstants.nameOfUpdate,
              style: TextStyle(
                fontSize: 16.sp,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
                fontFamily: kFontFamily,
              ),
            ),
            textField: CustomTextField(
                controller: nameOfUpdateController,
                hintText: StringConstants.nameOfUpdate,
                onChanged: (value) {
                  if (value.isEmpty) {
                    errorNameOfUpdate.value =
                        StringConstants.thisFieldIsRequired;
                  } else {
                    errorNameOfUpdate.value = "";
                  }
                }),
            errorText: errorNameOfUpdate,
          ),
          SizedBox(height: 10.h),
          Text(
            StringConstants.selectRequest,
            style: TextStyle(
              fontSize: 16.sp,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: kFontFamily,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: kTextFieldFillColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(() => DropdownButton<String>(
                  dropdownColor: kTextFieldFillColor,
                  isExpanded: true,
                  underline: Container(),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: kPrimaryColor),
                  hint: Text(StringConstants.selectRequest,
                      style: kHintTextStyle),
                  value: selectedCategory.value,
                  onChanged: (String? value) {
                    selectedCategory.value = value;
                  },
                  items:
                      projectName.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ),
          Obx(() => categoryError.value != ""
              ? Text(
                  categoryError.value,
                  style: kErrorTextStyle,
                )
              : Container()),
          SizedBox(height: 10.h),
          Text(
            StringConstants.selectFile,
            style: TextStyle(
              fontSize: 16.sp,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: kFontFamily,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: kTextFieldFillColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    selectedFile.value != null
                        ? selectedFile.value!.path.split('/').last
                        : StringConstants.selectFile,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: kHintTextColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: kFontFamily,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickFile();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: kNeonColor, size: 16.sp),
                        SizedBox(width: 5.w),
                        Text(
                          StringConstants.upload,
                          style: kHintTextStyle.copyWith(color: kNeonColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => fileError.value != ""
              ? Text(
                  fileError.value,
                  style: kErrorTextStyle,
                )
              : Container()),
          SizedBox(height: 30.h),
          Obx(
            () => CustomRoundedButton(
              backgroundColor: kNeonColor,
              textColor: kPrimaryColor,
              loading: isLoading.value,
              text: StringConstants.uploadNewUpdate,
              onPressed: () {
                uploadUpdate();
              },
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    ),
  );
}
