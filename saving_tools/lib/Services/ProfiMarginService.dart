import 'package:saving_tools/Repositories/ProfitMarginRepository.dart';
import 'package:saving_tools/Services/GoalService.dart';

class ProfitMarginService {
  
  ProfitMarginRepository? _profitMarginRepository;
  GoalService? _goalService;

  ProfitMarginService () {
    _profitMarginRepository = ProfitMarginRepository();
    _goalService = GoalService();
  }


  Future<double> getProfitMargin() async {
    return await _profitMarginRepository!.getProfitMargin();
  }

  Future<void> incrementProfitMargin(double increment) async {
    await _profitMarginRepository!.incrementProfitMargin(increment);
    await _goalService!.updateGoalStatus(await getProfitMargin());
  }
}