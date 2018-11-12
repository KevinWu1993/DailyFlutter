import 'package:zhihudaily/model/daily_model.dart';

abstract class DailyRepository {
  Future<DailyModel> loadData();
}