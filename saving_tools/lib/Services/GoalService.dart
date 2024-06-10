import 'package:saving_tools/DTOs/GoalDTO.dart';
import 'package:saving_tools/DTOs/Mapper.dart';
import 'package:saving_tools/DTOs/UserDTO.dart';
import 'package:saving_tools/Entities/Goal.dart';
import 'package:saving_tools/Repositories/GoalRepository.dart';
import 'package:saving_tools/Repositories/WhoIs.dart';
import 'package:saving_tools/Services/UserService.dart';
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
    double? percent,
    required double amount,
    required double distributionPercentage,
    required int rank,
    int? userId,
  }
  ) async {
    String dateStr = "${date.day}/${date.month}/${date.year}";
    final goal = Goal(
      description: description,
      date: dateStr,
      percent: percent,
      amount: amount,
      distributionPercentage: distributionPercentage,
      rank: rank,

      userId: userId ?? 0,
    );
    
    await _goalRepository!.insertGoal(goal);
  }


  Future<List<GoalDTO>> getGoals(int? limit) async {
    UserDTO user = await UserService().getUser(await WhoIs.getActualUsername());
    List<Goal> goals = await _goalRepository!.getGoals(limit: limit, userId: user.id);
    List<GoalDTO> goalsDTO = [];
    for (Goal goal in goals) {
      goalsDTO.add(Mapper.GoalToGoalDTO(goal));
      
    }
    return goalsDTO;
  }

  Future<void> deleteGoal(int goalID) async {
    await _goalRepository!.deleteGoal(goalID);
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