import 'package:travel_app/data/model/package.dart';

import '../model/detail_package.dart';
import '../network/firebase_api_service.dart';

class TravelPackageRepository {
  final FirebaseApiService _firebaseApiService;

  TravelPackageRepository(this._firebaseApiService);

  Future<List<Package>> fetchPackages() async {
    final result = await _firebaseApiService.getPackages();
    return result;
  }

  Future<DetailPackage> fetchPackageDetail(String id) async {
    final result = await _firebaseApiService.getDetailPackage(id);
    return result;
  }

  Future<bool> isPackageLiked(String packageId) async {
    final result = await _firebaseApiService.isPackageLikedByUser(
        'saJ9hRqRMHVZPfN7Jv76', packageId);

    return result;
  }

  Future<bool> toggleLikePackage({required String packageId, required bool isLiked}) async {
    if (isLiked) {
      await _firebaseApiService.addPackageToUserLikes(
          userId: 'saJ9hRqRMHVZPfN7Jv76', packageId: packageId);
      return true;
    } else {
      await _firebaseApiService.removePackageFromUserLikes(
          userId: 'saJ9hRqRMHVZPfN7Jv76', packageId: packageId);
      return false;
    }
  }
}
