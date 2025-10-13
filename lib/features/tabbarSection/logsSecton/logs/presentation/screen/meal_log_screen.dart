import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/text_feild.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/features/tabbarSection/logsSecton/logs/presentation/widgets/horizontal_calender.dart';
import '../../../../../../../../core/routes/route_import.dart';

class MealLogScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final mealTypeController = TextEditingController();
  final mealDescriptionController = TextEditingController();
  final selectedImageProvider = StateProvider<File?>((ref) => null);

  MealLogScreen({super.key});

  Future<void> _pickImage(
    BuildContext context,
    WidgetRef ref,
    ImageSource source,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      ref.read(selectedImageProvider.notifier).state = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImage = ref.watch(selectedImageProvider);
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: 'Meal Log',
        onBackTap: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HorizontalWeekCalendar(),
                SizedBox(height: mq.height * 0.02),
                UrbanistApptext(
                  text: "Meal Type",
                  fontSize: mq.width * 0.042,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
                SizedBox(height: mq.height * 0.005),
                AppTextField(
                  controller: mealTypeController,
                  hint: "Breakfast / Lunch / Brunch / Dinner etc",
                  fontSize: mq.width * 0.036,
                  labelFontSize: mq.width * 0.036,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your meal type' : null,
                ),
                SizedBox(height: mq.height * 0.02),
                UrbanistApptext(
                  text: "Meal Description",
                  fontSize: mq.width * 0.042,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
                SizedBox(height: mq.height * 0.005),
                AppTextField(
                  controller: mealDescriptionController,
                  hint: "Eg, Spinach Salad with carrots and cucumber",
                  fontSize: mq.width * 0.036,
                  labelFontSize: mq.width * 0.036,
                  validator: (val) => val!.isEmpty
                      ? 'Please enter your meal Description'
                      : null,
                ),
                SizedBox(height: mq.height * 0.02),
                UrbanistApptext(
                  text: "Upload Image",
                  fontSize: mq.width * 0.042,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
                SizedBox(height: mq.height * 0.005),
                GestureDetector(
                  onTap: () async {
                    _pickImage(context, ref, ImageSource.gallery);

                    // showModalBottomSheet(
                    //   context: context,
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(20),
                    //     ),
                    //   ),
                    //   builder: (_) => Padding(
                    //     padding: const EdgeInsets.all(16),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         ElevatedButton.icon(
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //             _pickImage(context, ref, ImageSource.gallery);
                    //           },
                    //           icon: const Icon(Icons.photo_library),
                    //           label: const Text("Gallery"),
                    //         ),
                    //         ElevatedButton.icon(
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //             _pickImage(context, ref, ImageSource.camera);
                    //           },
                    //           icon: const Icon(Icons.camera_alt),
                    //           label: const Text("Camera"),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: mq.width * 0.28,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(mq.width * 0.02),
                      border: Border.all(color: AppColor.border, width: 1.5),
                    ),
                    child: selectedImage == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppSvg.galleryIcon),
                              SizedBox(width: mq.width * 0.02),
                              UrbanistApptext(
                                text: "Select File / ",
                                fontSize: mq.width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: AppColor.textGreyColor3,
                              ),
                              SvgPicture.asset(AppSvg.cameraIcon),
                              SizedBox(width: mq.width * 0.02),
                              UrbanistApptext(
                                text: "Capture a picture",
                                fontSize: mq.width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: AppColor.textGreyColor3,
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                              mq.width * 0.02,
                            ),
                            child: Image.file(
                              selectedImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: mq.height * 0.05),
                CustomButton(
                  text: 'Add Meal',
                  onPressed: () {
                    context.pop();
                  },
                  height: mq.height * 0.06,
                  fontSize: mq.width * 0.04,
                  fontWeight: FontWeight.w500,
                  borderRadius: mq.width * 0.02,
                  borderColor: AppColor.primaryColor,
                  color: AppColor.primaryColor,
                  textColor: AppColor.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
