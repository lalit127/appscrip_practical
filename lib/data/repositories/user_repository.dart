import 'package:appscrip_pract/data/models/user_model.dart';
import 'package:appscrip_pract/utils/constants.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final Dio _dio = Dio();
  Future<List<UserModel>> fetchUsers() async {
    final response = await _dio.get(AppConstant.baseUrl);
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
