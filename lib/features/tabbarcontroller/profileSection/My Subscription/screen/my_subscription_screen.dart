import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';
import '../providers/my_subscription_provider.dart';
import 'widget/my_subscription_widget.dart';

class MySubscriptionScreen extends ConsumerWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final state = ref.watch(mySubscriptionProvider);
    final notifier = ref.read(mySubscriptionProvider.notifier);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: UrbanistApptext(
          text: AppText.mySubscription,
          fontSize: width * (24 / width),
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: AppColor.black,
        ),
        backgroundColor: AppColor.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * (24 / width)),
          child: SingleChildScrollView(
            child: Column(children: [MySubscriptionWidget()]),
          ),
        ),
      ),
    );
  }
}
