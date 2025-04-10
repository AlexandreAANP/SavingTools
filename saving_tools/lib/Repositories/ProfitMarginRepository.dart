import 'package:saving_tools/Repositories/WhoIs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfitMarginRepository {
  
  String profitMarignKey = "profitMargin";

  Future<SharedPreferences>? prefs;

  ProfitMarginRepository(){
    prefs = SharedPreferences.getInstance();
  }

  Future<void> setProfitMargin(double profitMargin) async {
    String key = await WhoIs.getActualUsername();
    await prefs!.then((value) => value.setDouble("${key}.${profitMarignKey}", profitMargin));
  }

  Future<void> incrementProfitMargin(double increment) async {
    double profitMargin = await getProfitMargin();
    profitMargin += increment;
    await setProfitMargin(profitMargin);
  }

  Future<double> getProfitMargin() async {
    double? toReturn;
    String key = await WhoIs.getActualUsername();
    await prefs!.then((value) => toReturn = value.getDouble("${key}.${profitMarignKey}"));
    if(toReturn == null){
      await setProfitMargin(0.0);
      return 0.0;
    }else{
      return toReturn!;
    }

  }
}