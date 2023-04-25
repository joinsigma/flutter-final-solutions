import 'package:travel_app/data/network/firebase_api_service.dart';

class UserRepository {
  final FirebaseApiService _firebaseApiService;

  UserRepository(this._firebaseApiService);

  Future<bool> isTravelPackageLiked(String packageId) async {
    final result = await _firebaseApiService.isPackageLikedByUser(
        'saJ9hRqRMHVZPfN7Jv76', packageId);

    return result;
  }


}
