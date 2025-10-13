import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/text_feild.dart';
import 'package:jimmy_sir_app/features/tabbarSection/logsSecton/logs/presentation/widgets/activity_container.dart';
import 'package:jimmy_sir_app/features/tabbarSection/logsSecton/logs/presentation/widgets/horizontal_calender.dart';
import 'package:jimmy_sir_app/features/tabbarSection/logsSecton/logs/provider/activity_logs_provider.dart';

import '../../../../../../core/routes/route_import.dart';

class ActivityLogScreen extends ConsumerWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, String>> activityTypes = [
      {'title': 'Aerobic'},
      {'title': 'Anaerobic'},
      {'title': 'Daily LifeStyle Activities'},
      {'title': 'Flexibility & Mind Body'},
      {'title': 'Strength & Training'},
    ];

    final activityDescriptionController = TextEditingController();

    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: 'Activity Log',
        onBackTap: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HorizontalWeekCalendar(),
              SizedBox(height: mq.height * 0.02),
              UrbanistApptext(
                text: 'Activity Type',
                fontSize: mq.width * 0.042,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              // SizedBox(height: mq.height * 0.02),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: mq.height * 0.02),
                itemCount: activityTypes.length,
                itemBuilder: (context, index) {
                  final expandedIndex = ref.watch(
                    expandedActivityIndexProvider,
                  );
                  final isExpanded = expandedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      ref.read(expandedActivityIndexProvider.notifier).state =
                          isExpanded ? null : index;
                    },
                    child: ActivityContainer(
                      isExpanded,
                      activityTypes[index]['title']!,
                    ),
                  );
                },
              ),
              UrbanistApptext(
                text: 'Activity Description',
                fontSize: mq.width * 0.042,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              SizedBox(height: mq.height * 0.005),
              AppTextField(
                controller: activityDescriptionController,
                hint: 'Eg, I ran for 2 km today',
                fontSize: mq.width * 0.036,
                labelFontSize: mq.width * 0.036,
                maxLines: 3,
                validator: (val) => val!.isEmpty
                    ? 'Please enter your activity description'
                    : null,
              ),

              SizedBox(height: mq.height * 0.02),
              CustomButton(
                text: 'Add Activity',
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
    );
  }
}
