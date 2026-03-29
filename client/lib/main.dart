import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/network/dio_client.dart';
import 'core/network/api_service.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/forgot_password.dart';
import 'features/auth/domain/usecases/get_profile.dart';
import 'features/auth/domain/usecases/update_profile.dart';
import 'features/auth/domain/usecases/logout_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyAppWithDependencies(sharedPreferences: sharedPreferences));
}

class MyAppWithDependencies extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyAppWithDependencies({
    super.key,
    required this.sharedPreferences,
  });

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    final apiService = ApiService(dioClient);

    final authRemoteDataSource = AuthRemoteDataSourceImpl(apiService);

    final authRepository = AuthRepositoryImpl(
      prefs: sharedPreferences,
      remoteDataSource: authRemoteDataSource,
    );

    final registerUser = RegisterUser(authRepository);
    final loginUser = LoginUser(authRepository);
    final forgotPassword = ForgotPassword(authRepository);
    final getProfile = GetProfile(authRepository);
    final updateProfile = UpdateProfile(authRepository);
    final logoutUser = LogoutUser(authRepository);

    return BlocProvider(
      create: (context) => AuthBloc(
        registerUser: registerUser,
        loginUser: loginUser,
        forgotPassword: forgotPassword,
        getProfile: getProfile,
        updateProfile: updateProfile,
        logoutUser: logoutUser,
      ),
      child: const MyApp(),
    );
  }
}
