import 'package:get_it/get_it.dart';
import 'package:ubee_mini/features/authentication/data/data_source/firebase_user_api.dart';
import 'package:ubee_mini/features/authentication/data/repository/user_repository_impl.dart';
import 'package:ubee_mini/features/authentication/domain/repository/user_repository.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/age_validation.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/create_user.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/email_validation.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/password_match_check.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/password_validation.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/update_names_and_birthdate.dart';
import 'package:ubee_mini/features/authentication/presentation/bloc/authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature - Authentication
  // Bloc
  sl.registerFactory<AuthenticationBloc>(()=> AuthenticationBloc());
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
  sl.registerLazySingleton<UpdateNamesAndBirthdate>(() => UpdateNamesAndBirthdate(sl()));

    //! Feature -
  // Bloc

  // Repository

  // DataSource

  // Usecases

}
