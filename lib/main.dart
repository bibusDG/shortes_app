import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:shortes/router/page_router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'core/di.dart';
import 'features/main_page/domain/entities/user_note.dart';

void main() async{
  await GetStorage.init();
  final userData = GetStorage();
  userData.writeIfNull('listOfNotes', []);
  userData.writeIfNull('language', '');

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en', 'US'),
        child: HookedBlocConfigProvider(
            injector: () => getIt.get,
            builderCondition: (state) => state != null, // Global build condition
            listenerCondition: (state) => state != null, // Global listen condition
            child: MyApp(pageRouter: MyPageRouter(),))
    ),
  );
}

class MyApp extends HookWidget {
  const MyApp({super.key, required this.pageRouter});
  final MyPageRouter pageRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1920, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ]),
      routerConfig: pageRouter.myRouter,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
    );
  }
}