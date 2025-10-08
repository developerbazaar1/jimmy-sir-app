import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class HorizontalWeekCalendar extends ConsumerWidget {
  const HorizontalWeekCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendar = ref.watch(calendarProvider);
    final notifier = ref.read(calendarProvider.notifier);
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      height: width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(width * 0.02),
        boxShadow: [
          BoxShadow(
            color: AppColor.textGreyColor.withAlpha((0.2 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Month & Year inside container
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: notifier.previousWeek,
                color: AppColor.baseGrey,
              ),
              UrbanistApptext(
                text: DateFormat('MMMM yyyy').format(calendar.selectedDate),
                fontSize: width * 0.037,
                fontWeight: FontWeight.w600,
                color: AppColor.baseGrey,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: notifier.nextWeek,
                color: AppColor.baseGrey,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 7-Day Calendar Row
          SizedBox(
            height: width * 0.18,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 7,
              padding: EdgeInsets.zero,
              separatorBuilder: (_, __) => SizedBox(width: width * 0.03),
              itemBuilder: (context, index) {
                final date = calendar.startOfWeek.add(Duration(days: index));
                final isSelected =
                    date.day == calendar.selectedDate.day &&
                    date.month == calendar.selectedDate.month &&
                    date.year == calendar.selectedDate.year;

                return GestureDetector(
                  onTap: () => notifier.selectDate(date),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Day of Week
                      UrbanistApptext(
                        text: DateFormat('E').format(date).toUpperCase(),
                        fontSize: width * 0.025,
                        fontWeight: FontWeight.w500,
                        color: AppColor.weekGray,
                      ),
                      SizedBox(height: width * 0.035),

                      // Date Circle
                      Container(
                        width: width * 0.09,
                        height: width * 0.09,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.primaryColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: UrbanistApptext(
                          text: date.day.toString(),
                          fontSize: width * 0.037,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColor.white
                              : AppColor.baseGrey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>(
  (ref) {
    return CalendarNotifier();
  },
);

class CalendarState {
  final DateTime selectedDate;
  final DateTime startOfWeek;

  CalendarState({required this.selectedDate, required this.startOfWeek});

  CalendarState copyWith({DateTime? selectedDate, DateTime? startOfWeek}) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      startOfWeek: startOfWeek ?? this.startOfWeek,
    );
  }
}

class CalendarNotifier extends StateNotifier<CalendarState> {
  CalendarNotifier()
    : super(
        CalendarState(
          selectedDate: DateTime.now(),
          startOfWeek: DateTime.now().subtract(
            Duration(days: DateTime.now().weekday % 7),
          ),
        ),
      );

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void nextWeek() {
    state = state.copyWith(
      startOfWeek: state.startOfWeek.add(const Duration(days: 7)),
    );
  }

  void previousWeek() {
    state = state.copyWith(
      startOfWeek: state.startOfWeek.subtract(const Duration(days: 7)),
    );
  }
}
