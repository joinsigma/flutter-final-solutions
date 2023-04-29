import 'package:travel_app/data/model/package.dart';

import '../model/detail_package.dart';
import '../network/firebase_api_service.dart';
import '../storage/local_storage_service.dart';

class TravelPackageRepository {
  final FirebaseApiService _firebaseApiService;
  final LocalStorageService _localStorageServie;

  TravelPackageRepository(this._firebaseApiService,this._localStorageServie);

  Future<List<Package>> fetchPackages() async {
    final result = await _firebaseApiService.getPackages();
    return result;
  }

  Future<DetailPackage> fetchPackageDetail(String id) async {
    final result = await _firebaseApiService.getDetailPackage(id);
    return result;
  }

  Future<bool> isPackageLiked(String packageId) async {
    final uid = await _localStorageServie.getUserId();
    final result = await _firebaseApiService.isPackageLikedByUser(
        uid, packageId);

    return result;
  }

  Future<void> likePackage({
    required String packageId,
  }) async {
    final uid = await _localStorageServie.getUserId();
    await _firebaseApiService.addPackageToUserLikes(
      userId: uid,
      packageId: packageId,
    );
  }

  Future<List<Package>> fetchLikedPackages() async {
    final uid = await _localStorageServie.getUserId();
    print(uid);
    return await _firebaseApiService
        .getLikedPackagesByUser(uid);
  }

  Future<void> unLikePackage({
    required String packageId,
  }) async {
    final uid = await _localStorageServie.getUserId();
    await _firebaseApiService.removePackageFromUserLikes(
        userId: uid, packageId: packageId);
  }
}
