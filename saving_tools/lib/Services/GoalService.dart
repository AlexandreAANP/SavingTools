import 'package:saving_tools/DTOs/GoalDTO.dart';
import 'package:saving_tools/DTOs/Mapper.dart';
import 'package:saving_tools/DTOs/UserDTO.dart';
import 'package:saving_tools/Entities/Goal.dart';
import 'package:saving_tools/Repositories/GoalRepository.dart';
import 'package:saving_tools/Repositories/WhoIs.dart';
import 'package:saving_tools/Services/ProfiMarginService.dart';
import 'package:saving_tools/Services/UserService.dart';
import 'package:sqflite/sqflite.dart';

class GoalPercentageByRank{
  static double RANK_1 = 0.5;
  static double RANK_2 = 0.25;
  static double RANK_3 = 0.15;
  static double RANK_4 = 0.075;
  static double RANK_5 = 0.035;

  static double getPercentageByRank(int rank){
    switch(rank){
      case 1:
        return RANK_1;
      case 2:
        return RANK_2;
      case 3:
        return RANK_3;
      case 4:
        return RANK_4;
      case 5:
        return RANK_5;
      default:
        return 0;
    }
  }
}

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


  Future<void> updateGoalStatus(double profitMargin) async {

    //Case there is no profit margin all goals percentages are set to 0
    if (profitMargin < 0) {
      List<Goal> goals = await _goalRepository!.getGoals();
      for (Goal goal in goals) {
        goal.percent = 0.0;
        await _goalRepository!.updateGoal(goal);
      }
      return;
    }


    List<Goal> goals = await _goalRepository!.getGoals();
    double goalsPercentage = 0.0;

    for (Goal goal in goals) {
      goalsPercentage += GoalPercentageByRank.getPercentageByRank(goal.rank!);
    }

    double howMuchFreePercentageToDistribute = (1 - goalsPercentage) / goals.length;

    for (Goal goal in goals) {
      double profitAvailable = (GoalPercentageByRank.getPercentageByRank(goal.rank!) + howMuchFreePercentageToDistribute) * profitMargin;
      double profitDefined = goal.distributionPercentage!/100 * profitAvailable;
      double percentage = profitDefined / goal.amount!;
      goal.percent = percentage > 1 ? 1 : percentage;
      if (goal.percent == 1) {
        profitMargin -= goal.amount!;
      }else{
        profitMargin -= profitDefined;
      }
      await _goalRepository!.updateGoal(goal);
    }

    
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

  Future<List<int>> getRanksAvailable() async {
    List<Goal> goals = await _goalRepository!.getGoals();
    List<int> ranks = [1, 2, 3, 4, 5];
    for (Goal goal in goals) {
      ranks.remove(goal.rank);
    }
    return ranks;
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