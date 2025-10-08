import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/poppins_apptext.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import '../widget/life_style_score.dart';
import '../widget/profile_header.dart';

class SectionItem {
  final String id;
  final String title;
  final String subtitle;
  final Widget details;
  bool expanded;

  SectionItem({
    required this.id,
    required this.title,
    this.subtitle = '',
    required this.details,
    this.expanded = false,
  });
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<SectionItem> sections;

  @override
  void initState() {
    super.initState();
    sections = [
      SectionItem(
        id: "Today's Suggestion",
        title: "Today's key appointments",
        subtitle: "Today's key appointments",
        details: Builder(
          builder: (context) => _buildTodaySuggestionDetails(context),
        ),
        expanded: true,
      ),
      SectionItem(
        id: 'goals',
        title: 'Goals & Milestones',
        // subtitle: '',
        details: Builder(
          builder: (context) => _buildGoalsMilestonesDetails(context),
        ),
        expanded: true,
      ),
      SectionItem(
        id: 'health',
        title: 'Health Overview',
        subtitle: '',
        details: Builder(
          builder: (context) => _buildHealthOverviewDetails(context),
        ),
        expanded: true,
      ),
    ];
  }

  // ---------- replace these builder stubs with your real details widgets ----------
  static Widget _buildTodaySuggestionDetails(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TipContainerWidget(text: 'Take a 5-minute mindful break'),
          SizedBox(height: height * 0.01),
          TipContainerWidget(
            text:
                'Swap one snack for fruit – a small change makes a big impact.',
          ),
          SizedBox(height: height * 0.01),
          TipContainerWidget(
            text: 'Unplug before bed – give your mind time to rest.',
          ),
          SizedBox(height: height * 0.01),
          Container(
            width: width * 0.9,
            padding: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.04,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.primaryColor2.withOpacity(0.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UrbanistApptext(
                  text: 'Tip of the day',
                  fontSize: width * 0.03,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: height * 0.01),
                UrbanistApptext(
                  text: 'Drink more water right after waking up.',
                  fontSize: width * 0.03,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.01),
          UrbanistApptext(
            text: 'Questions',
            fontSize: width * 0.04,
            fontWeight: FontWeight.w800,
            color: AppColor.primaryColor3,
          ),
          SizedBox(height: height * 0.01),
          QuestionRadioCard(
            question: 'Do you feel thirsty when you wake up?',
            onChanged: (value) {
              print('Selected: $value');
            },
          ),
          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }

  static Widget _buildGoalsMilestonesDetails(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGoalItem(
                  context,
                  width,
                  svg: AppSvg.goalIcon,
                  iconColor: AppColor.pinkColor,
                  title: "Weight Loss Goal",
                  progress: 0.75,
                  progressColor: AppColor.pinkColor,
                ),
                SizedBox(height: height * 0.02),

                _buildGoalItem(
                  context,
                  width,
                  svg: AppSvg.goalIcon2,
                  iconColor: AppColor.yellowColor,
                  title: "Monthly Step",
                  progress: 0.9,
                  progressColor: AppColor.yellowColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildHealthOverviewDetails(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        children: [
          healthOverviewtile(
            title: AppText.sleepQuality,
            icon: AppSvg.bedIcon,
            onTap: () {
              context.pushNamed(RouteNames.sleepQualityScreen);
            },
          ),
          healthOverviewtile(
            title: AppText.hydrationAwareness,
            icon: AppSvg.dropIcon,
            onTap: () {},
          ),
          healthOverviewtile(
            title: AppText.nutritionBalance,
            icon: AppSvg.leafIcon,
            onTap: () {},
          ),
          healthOverviewtile(
            title: AppText.activityLevel,
            icon: AppSvg.runIcon,
            onTap: () {},
          ),
          healthOverviewtile(
            title: AppText.mood,
            icon: AppSvg.smileIcon,
            onTap: () {},
          ),
        ],
      ),
    );
  }
  // -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: 12,
            ),
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                const ProfileHeader(),
                SizedBox(height: height * 0.02),
                const LifeStyleScore(),
                SizedBox(height: height * 0.02),

                // ---- Draggable sections area ----
                Builder(
                  builder: (context) {
                    final double headerHeight = height * 0.070;

                    return Container(
                      color: Colors.white,

                      child: ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sections.length,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex -= 1;
                            final item = sections.removeAt(oldIndex);
                            sections.insert(newIndex, item);
                          });
                        },
                        itemBuilder: (context, index) {
                          final item = sections[index];
                          return _buildDraggableCard(
                            context,
                            index,
                            item,
                            headerHeight,
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: height * 0.02),
                Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(AppSvg.homeBannerImage),
                ),

                // TextField container as per image
                Container(
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.border, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      // Microphone icon on the left

                      // Text input field
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: width * 0.035,
                              fontFamily: 'urbanist',
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                              horizontal: width * 0.03,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontFamily: 'urbanist',
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.04),
                        child: Icon(
                          Icons.mic_none,
                          color: Colors.grey.shade600,
                          size: width * 0.07,
                        ),
                      ),

                      // Orange send button on the right
                      Container(
                        margin: EdgeInsets.only(right: width * 0.02),
                        width: width * 0.1,
                        height: width * 0.1,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: width * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ChatExpandFAB(),
    );
  }

  Widget _buildDraggableCard(
    BuildContext context,
    int index,
    SectionItem item,
    double headerHeight,
  ) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      key: ValueKey(item.id),
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.01,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.border.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // header card
          Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: headerHeight,
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UrbanistApptext(
                          text: item.title,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w700,
                        ),
                        if (item.subtitle.isNotEmpty)
                          UrbanistApptext(
                            text: item.subtitle,
                            fontSize: width * 0.032,
                            fontWeight: FontWeight.w600,
                          ),
                      ],
                    ),
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            item.expanded = !item.expanded;
                          });
                        },
                        child: SizedBox(
                          width: width * 0.1,
                          height: height * 0.05,
                          child: SvgPicture.asset(AppSvg.dragIcon),
                        ),
                      ),

                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: ReorderableDelayedDragStartListener(
                            index: index,
                            child: Container(
                              width: width * 0.1,
                              height: height * 0.05,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: item.expanded
                ? Container(child: item.details)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

Widget _buildGoalItem(
  BuildContext context,
  double width, {

  required String svg,
  required Color iconColor,
  required String title,
  required double progress,
  required Color progressColor,
}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: width * 0.03,
      vertical: height * 0.018,
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColor.border.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.04,
              width: width * 0.08,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(child: SvgPicture.asset(svg)),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UrbanistApptext(
                        text: title,
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                      UrbanistApptext(
                        text: "${(progress * 100).toInt()}%",
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.008),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: height * 0.007,
                      backgroundColor: Colors.grey[200],
                      color: progressColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class TipContainerWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;

  const TipContainerWidget({
    super.key,
    required this.text,
    this.icon = Icons.circle,
    this.iconColor,
    this.backgroundColor = Colors.white,
    this.borderRadius = 5.0,
    this.padding,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding:
          padding ??
          EdgeInsets.symmetric(
            vertical: height * 0.01,
            horizontal: width * 0.02,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? AppColor.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor ?? AppColor.primaryColor, size: 12),
          SizedBox(width: width * 0.02),
          Expanded(
            child: UrbanistApptext(
              text: text,
              fontSize: width * 0.03,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionRadioCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final Function(String)? onChanged;
  final String? selectedOption;

  const QuestionRadioCard({
    super.key,
    required this.question,
    this.options = const ['Yes', 'No', 'A little'],
    this.onChanged,
    this.selectedOption,
  });

  @override
  State<QuestionRadioCard> createState() => _QuestionRadioCardState();
}

class _QuestionRadioCardState extends State<QuestionRadioCard> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.015,
        horizontal: width * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Question Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: AppColor.primaryColor, size: 10),
              SizedBox(width: width * 0.02),
              Expanded(
                child: UrbanistApptext(
                  text: widget.question,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.015),

          /// Radio Options Row
          Row(
            children: widget.options.map((option) {
              final isSelected = selectedValue == option;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedValue = option);
                  if (widget.onChanged != null) widget.onChanged!(option);
                },
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: isSelected
                          ? AppColor.primaryColor
                          : AppColor.border,
                      size: 20,
                    ),
                    SizedBox(width: width * 0.01),
                    UrbanistApptext(
                      text: option,
                      fontSize: width * 0.033,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColor.primaryColor
                          : Colors.black87,
                    ),
                    SizedBox(width: width * 0.04),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class healthOverviewtile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final Color? color;
  healthOverviewtile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.01),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.border),
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: height * 0.03,
                width: width * 0.03,
              ),

              SizedBox(width: width * 0.04),
              PoppinsApptext(
                text: title,
                fontSize: width * 0.03,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: AppColor.textColor,
              ),
              Spacer(),

              Icon(Icons.arrow_forward_ios, size: width * (18 / width)),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatExpandFAB extends StatefulWidget {
  const ChatExpandFAB({super.key});

  @override
  State<ChatExpandFAB> createState() => _ChatExpandFABState();
}

class _ChatExpandFABState extends State<ChatExpandFAB>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );
  }

  void _toggleContainer() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        /// Animated expanding chat container
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: _isOpen ? height * 0.17 : height * 0.2,
          right: width * 0.01,
          child: ScaleTransition(
            scale: _animation,
            child: AnimatedOpacity(
              opacity: _isOpen ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: width * 0.9,
                height: height * 0.4,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    _chatBubble(
                      context: context,
                      isUser: true,
                      icon: Icons.chat_bubble,
                      message: "Hello! How can I help you today?",
                    ),
                    _chatBubble(
                      context: context,
                      isUser: false,
                      icon: Icons.chat_bubble,
                      message: "Hello! How can I help you today?",
                    ),
                    Container(
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.border, width: 1.5),
                      ),
                    ),
                    // TextField container as per image
                    // Container(
                    //   height: height * 0.06,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: AppColor.border, width: 1.5),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       // Microphone icon on the left

                    //       // Text input field
                    //       Expanded(
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //             hintText: 'Type your message...',
                    //             hintStyle: TextStyle(
                    //               color: Colors.grey.shade600,
                    //               fontSize: width * 0.035,
                    //               fontFamily: 'urbanist',
                    //             ),
                    //             border: InputBorder.none,
                    //             contentPadding: EdgeInsets.symmetric(
                    //               vertical: height * 0.015,
                    //               horizontal: width * 0.03,
                    //             ),
                    //           ),
                    //           style: TextStyle(
                    //             fontSize: width * 0.035,
                    //             fontFamily: 'urbanist',
                    //             color: AppColor.black,
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(right: width * 0.04),
                    //         child: Icon(
                    //           Icons.mic_none,
                    //           color: Colors.grey.shade600,
                    //           size: width * 0.07,
                    //         ),
                    //       ),

                    //       // Orange send button on the right
                    //       Container(
                    //         margin: EdgeInsets.only(right: width * 0.02),
                    //         width: width * 0.1,
                    //         height: width * 0.1,
                    //         decoration: BoxDecoration(
                    //           color: AppColor.primaryColor,
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: Icon(
                    //           Icons.send,
                    //           color: Colors.white,
                    //           size: width * 0.05,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// Floating Action Button
        Padding(
          padding: EdgeInsets.only(bottom: height * 0.09),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            backgroundColor: AppColor.bottomBarColor,
            elevation: 0,
            onPressed: _toggleContainer,
            child: AnimatedRotation(
              duration: Duration(milliseconds: 300),
              turns: _isOpen ? 0.250 : 0.0,
              child: _isOpen
                  ? Icon(
                      Icons.close,
                      color: AppColor.primaryColor,
                      size: width * 0.08,
                    )
                  : SvgPicture.asset(
                      AppSvg.imgFloat,
                      height: height * 0.04,
                      width: width * 0.04,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _chatBubble({
  required BuildContext context,
  required bool isUser,
  required IconData icon,
  required String message,
}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: isUser
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser)
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(width * 0.01),
                decoration: BoxDecoration(
                  color: AppColor.bottomBarColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SvgPicture.asset(
                  AppSvg.imgFloat,
                  height: height * 0.03,
                  width: width * 0.03,
                ),
              ),
            if (!isUser) SizedBox(width: width * 0.02),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(width * 0.02),
                decoration: BoxDecoration(
                  color: isUser
                      ? Colors.deepPurple.shade50
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: UrbanistApptext(
                  text: message,
                  fontSize: width * 0.03,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),
              ),
            ),
            if (isUser) SizedBox(width: width * 0.02),
            if (isUser)
              CircleAvatar(
                radius: width * 0.03,
                backgroundColor: AppColor.bottomBarColor,
                backgroundImage: AssetImage(AppImages.personTemp),
              ),
          ],
        ),
      ),

      // ✅ Added TextField below the bubble
      // Container(
      //   margin: const EdgeInsets.only(top: 8),
      //   padding: const EdgeInsets.symmetric(horizontal: 12),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Colors.grey.shade300),
      //     borderRadius: BorderRadius.circular(30),
      //     color: Colors.grey.shade100,
      //   ),
      //child:
      // TextField(
      //   decoration: InputDecoration(
      //     hintText: 'Type a message...',
      //     border: InputBorder.none,
      //     suffixIcon: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Icon(Icons.mic_none, color: Colors.grey),
      //         const SizedBox(width: 8),
      //         Icon(Icons.send, color: Colors.deepPurple),
      //       ],
      //     ),
      //   ),
      // ),
      //),
    ],
  );
}











































//----------ROUGHT WORK ---------------------------------


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_svg.dart';
// import 'widget/life_style_score.dart';
// import 'widget/profile_header.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   List<Color> containerColors = [Colors.red, Colors.blue, Colors.green];

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       floatingActionButton: null,

//       body: Stack(
//         children: [
//           SafeArea(
//             child: SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight:
//                       MediaQuery.of(context).size.height -
//                       MediaQuery.of(context).padding.top -
//                       MediaQuery.of(context).padding.bottom -
//                       32,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: width * 0.05,
//                     vertical: height * 0.01,
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(height: width * 0.055),
//                       ProfileHeader(),
//                       SizedBox(height: width * 0.051),
//                       LifeStyleScore(),
//                       SizedBox(height: width * 0.0204),

//                       SizedBox(
//                         height:
//                             containerColors.length * (width * 0.15 + 8) + 100,
//                         child: ReorderableListView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: containerColors.length,
//                           onReorder: (oldIndex, newIndex) {
//                             setState(() {
//                               if (newIndex > oldIndex) {
//                                 newIndex -= 1;
//                               }
//                               final color = containerColors.removeAt(oldIndex);
//                               containerColors.insert(newIndex, color);
//                             });
//                           },
//                           itemBuilder: (context, index) {
//                             final color = containerColors[index];
//                             return Container(
//                               key: ValueKey('$color-$index'),
//                               height: width * 0.15,
//                               margin: EdgeInsets.symmetric(vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: color.withOpacity(0.3),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 16),
//                                       child: Icon(
//                                         Icons.drag_handle,
//                                         color: Colors.white,
//                                         size: 24,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Container ${index + 1}',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 16),
//                                       child: Icon(
//                                         Icons.more_vert,
//                                         color: Colors.white,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Custom positioned FloatingActionButton
//           Positioned(
//             bottom: 100,
//             right: 20,
//             child: FloatingActionButton(
//               backgroundColor: AppColor.bottomBarColor,
//               child: SvgPicture.asset(AppSvg.imgFloat),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(width * (40 / width)),
//               ),
//               elevation: 5,
//               onPressed: () {
//                 setState(() {
//                   containerColors.add(Colors.purple);
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }