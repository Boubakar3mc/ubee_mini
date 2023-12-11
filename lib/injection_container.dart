import 'package:get_it/get_it.dart';
import 'package:ubee_mini/features/signin/data/data_source/firebase_user_api.dart';
import 'package:ubee_mini/features/signin/data/repository/user_repository_impl.dart';
import 'package:ubee_mini/features/signin/domain/repository/user_repository.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/age_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/create_user.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/email_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/password_match_check.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/password_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/update_user.dart';
import 'package:ubee_mini/features/signin/presentation/bloc/signin_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature - signin
  // Bloc
  sl.registerFactory<SigninBloc>(()=> SigninBloc());
  // Repository
  sl.registerLazySingleton<UserApi>(() => FireBaseUserApi());
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  // DataSource

  // Usecases
  sl.registerLazySingleton<CreateUser>(() => CreateUser(sl()));
  sl.registerLazySingleton<EmailValidation>(() => EmailValidation());
  sl.registerLazySingleton<PasswordMatchCheck>(() => PasswordMatchCheck());
  sl.registerLazySingleton<PasswordValidation>(() => PasswordValidation());
  sl.registerLazySingleton<AgeValidation>(() => AgeValidation());
  sl.registerLazySingleton<UpdateUser>(() => UpdateUser(sl()));

    //! Feature -
  // Bloc

  // Repository

  // DataSource

  // Usecases

}
