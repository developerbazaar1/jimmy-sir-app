class MembershipPlan {
  final String title;
  final String subtitle;
  final String price;
  final String period;
  final List<String> features;
  final String buttonText;

  MembershipPlan({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.period,
    required this.features,
    required this.buttonText,
  });
}
