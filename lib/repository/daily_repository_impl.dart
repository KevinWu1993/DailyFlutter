import 'package:zhihudaily/model/daily_model.dart';
import 'package:zhihudaily/repository/daily_repository.dart';
import 'package:dio/dio.dart';
import 'package:zhihudaily/api/daily_api.dart';

class DailyRepositoryImpl implements DailyRepository {

  @override
  Future<DailyModel> loadData() async{
    Response response;
    Dio dio = new Dio();
    response = await dio.get(DailyApi.LATEST_DAILY);
    if(response.statusCode == 200) {
      return new DailyModel.fromJson(response.data);
    } else{
      return null;
    }
  }

}