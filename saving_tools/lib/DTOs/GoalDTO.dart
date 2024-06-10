class GoalDTO {
  final int id;
  final String description;
  final double percent;
  final String percentText;
  final String date;
  final double amount;
  final bool isExpired;
  final bool isCompleted;

  GoalDTO(
      {
      required this.id,
      required this.description,
      required this.percent,
      required this.percentText,
      required this.date,
      required this.amount,
      required this.isExpired,
      required this.isCompleted,
      });
}