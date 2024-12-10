// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/model/city.dart';
import 'package:flutter_mvvm/model/costs/courier.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/repository/home_repository.dart';

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRepository();

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  ApiResponse<List<City>> originCityList = ApiResponse.completed([]);
  ApiResponse<List<City>> destinationCityList = ApiResponse.completed([]);
  ApiResponse<Courier> courierCost = ApiResponse.completed(const Courier());

  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  setOriginCityList(ApiResponse<List<City>> response) {
    originCityList = response;
    notifyListeners();
  }

  setDestinationCityList(ApiResponse<List<City>> response) {
    destinationCityList = response;
    notifyListeners();
  }

  Future<void> getOriginCityList(var provId) async {
    print("Getting cities for province: $provId");
    setOriginCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      print("Cities received: ${value.length}");
      setOriginCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print("Error: $error");
      setOriginCityList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getDestintCityList(String provId) async {
    setDestinationCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setDestinationCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDestinationCityList(ApiResponse.error(error.toString()));
    });
  }

  setCourierCost(ApiResponse<Courier> response) {
    courierCost = response;
    notifyListeners();
  }

  Future<void> calculateCourierCost(
      {required String origin,
      required String destination,
      required int weight,
      required String courier}) async {
    setCourierCost(ApiResponse.loading());
    _homeRepo
        .calculateShippingCost(
      origin: origin,
      destination: destination,
      weight: weight,
      courier: courier,
    )
        .then((value) {
      setCourierCost(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCourierCost(ApiResponse.error(error.toString()));
    });
  }
}
