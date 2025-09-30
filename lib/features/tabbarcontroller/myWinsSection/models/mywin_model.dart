class MyWinsModel {
  final int points;
  final double goalProgress;

  MyWinsModel({required this.points, required this.goalProgress});

  factory MyWinsModel.fromJson(Map<String, dynamic> json) {
    return MyWinsModel(
      points: json['points'] ?? 0,
      goalProgress: (json['goalProgress'] ?? 0).toDouble(),
    );
  }
}
