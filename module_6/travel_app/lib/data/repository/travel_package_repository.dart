import 'package:travel_app/data/model/package.dart';
import 'package:travel_app/data/network/travel_package_service.dart';

import '../model/detail_package.dart';

class TravelPackageRepository {
  final TravelPackageService _travelPackageService;

  TravelPackageRepository(this._travelPackageService);

  

  Future<List<Package>> fetchPackages() async {
    final result = await _travelPackageService.getPackages();
    return result;
  }

  Future<DetailPackage> fetchPackageDetail(String id) async {
    final result = await _travelPackageService.getDetailPackage(id);
    return result;
  }
}
