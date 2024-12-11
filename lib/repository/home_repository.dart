import 'package:flutter_mvvm/data/app_exception.dart';
import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/model/city.dart';
import 'package:flutter_mvvm/model/costs/courier.dart';
import 'package:flutter_mvvm/model/model.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/province');
      List<Province> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => Province.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<City>> fetchCityList(var provId) async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/city');
      List<City> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => City.fromJson(e))
            .toList();
      }

      List<City> selectedCities = [];
      for (var c in result) {
        if (c.provinceId == provId) {
          selectedCities.add(c);
        }
      }

      return selectedCities;
    } catch (e) {
      throw e;
    }
  }

  Future<Courier> calculateShippingCost({
    required String origin,
    required String destination,
    required int weight,
    required String courier,
  }) async {
    try {
      final body = {
        'origin': origin,
        'destination': destination,
        'weight': weight.toString(),
        'courier': courier,
      };

      dynamic response =
          await _apiServices.postApiResponse('/starter/cost', body);

      if (response['rajaongkir']['status']['code'] == 200) {
        return Courier.fromJson(response['rajaongkir']['results'][0]);
      }
      throw FetchDataException('Something went wrong');
    } catch (e) {
      // ignore: avoid_print
      print("Error calculating cost : $e");
      rethrow;
    }
  }
}
