import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/create_usecase_config.dart';
import 'package:localeats/features/user/presentation/bloc/bloc_login/user_bloc.dart';

import 'features/maps/presentation/bloc/bloc_maps/Mapsbloc.dart';
import 'features/menu/presentation/bloc/bloc_menu/menu_bloc.dart';
import 'features/user/presentation/bloc/bloc_create_local/create_local_bloc.dart';
import 'features/user/presentation/bloc/bloc_create_user/create_user_bloc.dart';
import 'features/user/presentation/bloc/bloc_locales/locales_bloc.dart';
import 'features/user/presentation/bloc/bloc_single_local/single_local_bloc.dart';
import 'location_usecase_config.dart';
import 'login_usecase_config.dart';
import 'menu_usecase.dart';
import 'splash_screen.dart';
import 'usecase_locales_config.dart';

// import 'usecase_config.dart';


MenuCaseUserConfig menuCaseUserConfig = MenuCaseUserConfig();
UsecaseLocalesConfig usecaseConfig = UsecaseLocalesConfig();
UseCaseUserConfig useCaseUserConfig = UseCaseUserConfig();
UseCaseCrearUserConfig useCaseCrearUserConfig = UseCaseCrearUserConfig();
UsecaseMapsConfig usecaseMapsConfig = UsecaseMapsConfig();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MenuBloc(menuCaseUserConfig.getMenuUsecase!)
        ),
        BlocProvider(
          create: (BuildContext context) => LocalesBloc(usecaseConfig.getLocalUsecase!)
        ),

        BlocProvider(
          create: (BuildContext context) => CreateLocalBloc(usecaseConfig.postNewLocalUsecase!)
        ),
        BlocProvider(
          create: (BuildContext context) => LocalesSingleBloc(usecaseConfig.getSingleLocalUsecase!)
        ),

        BlocProvider(
          create: (BuildContext context) => MapsBloc(usecaseMapsConfig.getLocationUsecase!)
        ),

        BlocProvider(
          create: (BuildContext context) => UserBloc(useCaseUserConfig.loginUserUsecase!, useCaseUserConfig.getAuthTokenUseCase!, useCaseUserConfig.removeTokenUseCase!)
        ),

        BlocProvider(
          create: (BuildContext context) => CreateUserBloc(useCaseCrearUserConfig.uSerCreateUseCase!)
        ),
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash(
        ),
      ),
    );
  }
}
