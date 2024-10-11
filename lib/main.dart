import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'sources/views/signup_page/signup_page.dart';
import 'sources/views/product_info_page/product_info_page.dart';
import 'sources/service/navigation_key.dart';
import 'resources/keys.dart';

import './sources/service/shared_util_provider.dart';
import './sources/service/auth_provider.dart';
import 'sources/views/login_page/login_page.dart';
import 'sources/views/bottom_navigation_controller/home_page.dart';
import 'sources/views/products_list_page/products_list_page.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	final SharedPreferences prefs = await SharedPreferences.getInstance();
  KakaoSdk.init(
    nativeAppKey: Secret.shared.kakaoApiKey,
  );

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLogined = ref.watch(isLoginedProvider);
    return MaterialApp(
				debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.shared.navigationState,
        initialRoute: !isLogined ? '/login' : '/home',
        routes: {
          '/login': (context) => const LogInPage(),
          '/signup': (context) => const SignUpPage(),
          '/home': (context) => const HomePage(),
          '/product': (context) => const ProductInfoPage(),
          '/productsList' : (context) => const ProductsListPage(),
        },
    );
  }
}
