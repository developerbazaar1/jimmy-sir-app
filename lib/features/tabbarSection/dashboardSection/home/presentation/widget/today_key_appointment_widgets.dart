// ---------- replace these builder stubs with your real details widgets ----------
import 'package:jimmy_sir_app/core/routes/route_import.dart';

Widget buildTodaySuggestionDetails(BuildContext context) {
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
          text: 'Swap one snack for fruit – a small change makes a big impact.',
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

//-----
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

//--------------

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
