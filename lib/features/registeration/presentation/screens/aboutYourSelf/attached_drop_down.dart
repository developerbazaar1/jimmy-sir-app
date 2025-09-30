import 'package:flutter/material.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class AttachedDropdown extends StatefulWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const AttachedDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<AttachedDropdown> createState() => _AttachedDropdownState();
}

class _AttachedDropdownState extends State<AttachedDropdown> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main container
        GestureDetector(
          onTap: () => setState(() => expanded = !expanded),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.018,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UrbanistApptext(
                  text: widget.value,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textBrownColor,
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.brown,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.01),

        // Expanded list
        if (expanded)
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: widget.items.map((item) {
                return InkWell(
                  onTap: () {
                    widget.onChanged(item);
                    setState(() => expanded = false);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                      horizontal: width * 0.02,
                    ),
                    child: UrbanistApptext(
                      text: item,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBrownColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
