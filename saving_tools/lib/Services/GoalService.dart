import 'package:saving_tools/Entities/Goal.dart';
import 'package:saving_tools/Repositories/GoalRepository.dart';
import 'package:sqflite/sqflite.dart';

class GoalService {
  GoalRepository? _goalRepository;

  static Database? database;
  GoalService._privateConstructor(Database databaseName) {
    _goalRepository = GoalRepository(databaseName);
  }

  static final GoalService _instance = GoalService._privateConstructor(database!);

  factory GoalService() {

    return _instance;
  }

  Future<void> addGoal({
    required String description,
    required DateTime date,
    required double percent,
    int? userId,
  }
  ) async {
    String dateStr = "${date.day}/${date.month}/${date.year}";
    final goal = Goal(
      description: description,
      date: dateStr,
      percent: percent,
      userId: userId ?? 0,
    );
    
    await _goalRepository!.insertGoal(goal);
  }


  Future<List<Goal>> getGoals(int? limit) async {
    return await _goalRepository!.getGoals();
  }

  Future<void> changePercentage(Goal goal, double percent) async {
    if (percent > 1) {
      percent = 1;
    }
    if (percent < 0) {
      percent = 0;
    }
    goal.percent = percent;
    await _goalRepository!.updateGoal(goal);
  }

  Future<void> changeStatus(Goal goal, bool status) async {
    goal.isCompleted = status;
    await _goalRepository!.updateGoal(goal);
  }

  Future<void> changeExpired(Goal goal, bool expired) async {
    goal.isExpired = expired;
    await _goalRepository!.updateGoal(goal);
  }
}