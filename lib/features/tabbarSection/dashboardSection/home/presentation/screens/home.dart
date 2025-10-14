import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/presentation/widget/goal_milestone_widgets.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/presentation/widget/healthOverview_widgets.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/presentation/widget/today_key_appointment_widgets.dart';
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
          builder: (context) => buildTodaySuggestionDetails(context),
        ),
        expanded: true,
      ),
      SectionItem(
        id: 'goals',
        title: 'Goals & Milestones',
        // subtitle: '',
        details: Builder(
          builder: (context) => buildGoalsMilestonesDetails(context),
        ),
        expanded: true,
      ),
      SectionItem(
        id: 'health',
        title: 'Health Overview',
        subtitle: '',
        details: Builder(
          builder: (context) => buildHealthOverviewDetails(context),
        ),
        expanded: true,
      ),
    ];
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

                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ChatExpandFAB(),
    );
  }

  //----------------------------------------start dragable card----------------------------------------
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

//----------------------------------------end dragable card-------------------------------------------

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
  final TextEditingController _messageController = TextEditingController();

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
  void dispose() {
    _controller.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // ------------------------ CHAT CONTAINER ------------------------
  Widget _buildChatContainer(double width, double height) {
    return Container(
      width: width * 0.6,
      height: height * 0.35,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _chatBubble(
                    context: context,
                    isUser: false,
                    icon: Icons.chat_bubble,
                    message: "Hi, How can I help you today?",
                  ),
                  _chatBubble(
                    context: context,
                    isUser: true,
                    icon: Icons.chat_bubble,
                    message:
                        "I'm feeling great! What activities do you suggest to stay energized?",
                  ),
                  _chatBubble(
                    context: context,
                    isUser: false,
                    icon: Icons.chat_bubble,
                    message:
                        "Dancing to your favorite tunes for a fun energy lift.",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.015),

          /// ---- TEXT FIELD WITH MIC + SEND ICON ----
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColor.border, width: width * 0.003),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(
                        fontSize: width * 0.032,
                        color: Colors.grey.shade500,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.mic_none_rounded,
                        color: AppColor.primaryColor,
                        size: width * 0.05,
                      ),
                      onPressed: () {
                        // Handle mic tap
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: AppColor.primaryColor,
                        size: width * 0.05,
                      ),
                      onPressed: () {
                        // Handle send tap
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Container(
          //   height: height * 0.06,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(30),
          //     border: Border.all(color: AppColor.border, width: 1.3),
          //     color: Colors.white,
          //   ),
          //   child: TextField(
          //     controller: _messageController,
          //     decoration: InputDecoration(
          //       hintText: "Type your message...",
          //       hintStyle: TextStyle(
          //         fontSize: width * 0.032,
          //         color: Colors.grey.shade500,
          //       ),
          //       border: InputBorder.none,
          //       contentPadding: EdgeInsets.symmetric(
          //         horizontal: width * 0.04,
          //         vertical: 8,
          //       ),
          //       suffixIcon: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           IconButton(
          //             icon: Icon(
          //               Icons.mic_none_rounded,
          //               color: AppColor.primaryColor,
          //             ),
          //             onPressed: () {
          //               // Handle voice input
          //             },
          //           ),
          //           IconButton(
          //             icon: Icon(
          //               Icons.send_rounded,
          //               color: AppColor.primaryColor,
          //             ),
          //             onPressed: () {
          //               // Handle send
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // ------------------------ BUILD METHOD ------------------------
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        if (_isOpen)
          Positioned(
            bottom: height * 0.17,
            right: width * 0.02,
            child: ScaleTransition(
              scale: _animation,
              child: AnimatedOpacity(
                opacity: _isOpen ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: _buildChatContainer(width, height),
              ),
            ),
          ),

        /// Floating Action Button
        Padding(
          padding: EdgeInsets.only(bottom: height * 0.09, right: width * 0.02),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            backgroundColor: AppColor.bottomBarColor,
            elevation: 4,
            onPressed: _toggleContainer,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: _isOpen ? 0.25 : 0.0,
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

// ------------------------ CHAT BUBBLE ------------------------
Widget _chatBubble({
  required BuildContext context,
  required bool isUser,
  required IconData icon,
  required String message,
}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return Container(
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
            padding: EdgeInsets.all(width * 0.025),
            decoration: BoxDecoration(
              color: isUser ? Colors.deepPurple.shade50 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: UrbanistApptext(
              text: message,
              fontSize: width * 0.032,
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
  );
}














































































//---------------------------------------rough work-------------------------------------------
// class ChatExpandFAB extends StatefulWidget {
//   const ChatExpandFAB({super.key});

//   @override
//   State<ChatExpandFAB> createState() => _ChatExpandFABState();
// }

// class _ChatExpandFABState extends State<ChatExpandFAB>
//     with SingleTickerProviderStateMixin {
//   bool _isOpen = false;
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutQuart,
//     );
//   }

//   void _toggleContainer() {
//     setState(() {
//       _isOpen = !_isOpen;
//       if (_isOpen) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }
//     @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         /// Animated expanding chat container
//         AnimatedPositioned(
//           duration: const Duration(milliseconds: 300),
//           bottom: _isOpen ? height * 0.17 : height * 0.2,
//           right: width * 0.01,

//           child: ScaleTransition(
//             scale: _animation,
//             child: AnimatedOpacity(
//               opacity: _isOpen ? 1 : 0,
//               duration: const Duration(milliseconds: 300),
//               child: Container(
//                 width: width * 0.6,
//                 height: height * 0.3,
//                 padding: EdgeInsets.all(width * 0.04),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(5),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   // mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _chatBubble(
//                       context: context,
//                       isUser: true,
//                       icon: Icons.chat_bubble,
//                       message: "Hello! How can I help you today?",
//                     ),
//                     _chatBubble(
//                       context: context,
//                       isUser: false,
//                       icon: Icons.chat_bubble,
//                       message: "Hello! How can I help you today?",
//                     ),
//                     SizedBox(height: height * 0.04),
//                     Container(
//                       height: height * 0.06,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: AppColor.border, width: 1.5),
//                       ),
//                     ),
//                     // TextField container as per image
                    
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),

//         /// Floating Action Button
//         Padding(
//           padding: EdgeInsets.only(bottom: height * 0.09),
//           child: FloatingActionButton(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(28),
//             ),
//             backgroundColor: AppColor.bottomBarColor,
//             elevation: 0,
//             onPressed: _toggleContainer,
//             child: AnimatedRotation(
//               duration: Duration(milliseconds: 300),
//               turns: _isOpen ? 0.250 : 0.0,
//               child: _isOpen
//                   ? Icon(
//                       Icons.close,
//                       color: AppColor.primaryColor,
//                       size: width * 0.08,
//                     )
//                   : SvgPicture.asset(
//                       AppSvg.imgFloat,
//                       height: height * 0.04,
//                       width: width * 0.04,
//                     ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// Widget _chatBubble({
//   required BuildContext context,
//   required bool isUser,
//   required IconData icon,
//   required String message,
// }) {
//   final height = MediaQuery.of(context).size.height;
//   final width = MediaQuery.of(context).size.width;

//   return Column(
//     crossAxisAlignment: isUser
//         ? CrossAxisAlignment.end
//         : CrossAxisAlignment.start,
//     children: [
//       Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         child: Row(
//           mainAxisAlignment: isUser
//               ? MainAxisAlignment.end
//               : MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (!isUser)
//               Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.all(width * 0.01),
//                 decoration: BoxDecoration(
//                   color: AppColor.bottomBarColor,
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: SvgPicture.asset(
//                   AppSvg.imgFloat,
//                   height: height * 0.03,
//                   width: width * 0.03,
//                 ),
//               ),
//             if (!isUser) SizedBox(width: width * 0.02),
//             Flexible(
//               child: Container(
//                 padding: EdgeInsets.all(width * 0.02),
//                 decoration: BoxDecoration(
//                   color: isUser
//                       ? Colors.deepPurple.shade50
//                       : Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: UrbanistApptext(
//                   text: message,
//                   fontSize: width * 0.03,
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.black,
//                 ),
//               ),
//             ),
//             if (isUser) SizedBox(width: width * 0.02),
//             if (isUser)
//               CircleAvatar(
//                 radius: width * 0.03,
//                 backgroundColor: AppColor.bottomBarColor,
//                 backgroundImage: AssetImage(AppImages.personTemp),
//               ),
//           ],
//         ),
//       ),

//       // ✅ Added TextField below the bubble
//       Container(
//         margin: const EdgeInsets.only(top: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(30),
//           color: Colors.grey.shade100,
//         ),
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: 'Type a message...',
//             border: InputBorder.none,
//             suffixIcon: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.mic_none, color: Colors.grey),
//                 const SizedBox(width: 8),
//                 Icon(Icons.send, color: Colors.deepPurple),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
