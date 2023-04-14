import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_bloc/data/model/user.dart';
import 'package:flutter_todo_bloc/data/network/rest_api_service.dart';
import 'package:flutter_todo_bloc/data/repository/user_repository.dart';
import 'package:flutter_todo_bloc/data/storage/local_storage_service.dart';
import 'package:mocktail/mocktail.dart';

class MockRestApiService extends Mock implements RestApiService {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

class UserRepositoryTest extends UserRepository {
  UserRepositoryTest(super.restApiService, super.localStorageService);

  @override
  Future<bool> isConnectedToInternet() async {
    return true;
  }
}

void main() {
  ///System under test
  late UserRepositoryTest sut;
  late MockRestApiService mockRestApiService;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockRestApiService = MockRestApiService();
    mockLocalStorageService = MockLocalStorageService();
    sut = UserRepositoryTest(mockRestApiService, mockLocalStorageService);
  });

  ///Test data
  const String userEmail = "user1@gmail.com";
  const String userPassword = "password";
  final User user = User(
      uid: "1",
      email: "user1@gmail.com",
      expiresIn: "3600",
      authToken: "token",
      refreshToken: "token");

  group("loginUser()", () {
    test("sign in an existing user using RestApiService", () async {
      ///Arrange
      when(() => mockRestApiService.signInUsingEmailPassword(
          email: userEmail,
          password: userPassword)).thenAnswer((_) async => user);

      ///Act
      await sut.loginUser(email: userEmail, password: userPassword);

      ///Assert
      verify(() => mockRestApiService.signInUsingEmailPassword(
          email: userEmail, password: userPassword)).called(1);
      verify(() => mockLocalStorageService.saveToken(user.authToken)).called(1);
      verify(() => mockLocalStorageService.saveUserId(user.uid)).called(1);
    });
  });
}
