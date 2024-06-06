import 'package:saving_tools/Entities/Goal.dart';
import 'package:saving_tools/Repositories/SearchTools/OrderBy.dart';
import 'package:saving_tools/Repositories/SearchTools/Search.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchUtils.dart';
import 'package:sqflite/sqflite.dart';

class GoalRepository{

  Database database;

  final String table = 'Goal';

  GoalRepository(this.database);

  Future<void> insertGoal(Goal goal) async {

      await this.database.insert(
        table,
        goal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
  }

  Future<List<Goal>> searchGoals({
                            Searchlike? searchLike,
                            Search? searchEquals,
                            bool searchEqualFirst = true,
                            OrderBy? order,
                            int? limit,
                            int? offset
                            }) async {

    String? whereString = SearchUtils.getWhereSearchString(searchLike: searchLike, searchEquals: searchEquals, searchEqualFirst: searchEqualFirst);
    
    List<String>? whereArgs = SearchUtils.getWhereArguments(searchLike: searchLike, searchEquals: searchEquals, searchEqualFirst: searchEqualFirst);  

    final List<Map<String, dynamic>> maps = await database.query(
                                                    table,
                                                    where: whereString,
                                                    whereArgs: whereArgs,
                                                    limit: limit,
                                                    offset: offset,
                                                    orderBy: order?.getOrderString());

    return List.generate(maps.length, (i) {
      return Goal(
        id: maps[i]['id'],
        description: maps[i]['description'],
        date: maps[i]['date'],
        percent: maps[i]['percent'],
      );
    });
  }


  Future<List<Goal>> getGoals() async {
    final List<Map<String, dynamic>> maps = await database.query(table);

    return List.generate(maps.length, (i) {
      return Goal(
        id: maps[i]['id'],
        description: maps[i]['description'],
        date: maps[i]['date'],
        percent: maps[i]['percent'],
      );
    });
  }


  Future<void> updateGoal(Goal goal) async {
    await database.update(
      table,
      goal.toMap(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }

  Future<void> deleteGoal(int id) async {
    await database.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}