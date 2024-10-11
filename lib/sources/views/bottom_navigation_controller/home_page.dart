import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../resources/color_asset/colors.dart';
import '../../service/procucts_provider.dart';

import '../drawer_page/drawer_page.dart';
import '../main_page/main_page.dart';
import '../user_info_page/user_info_page.dart';


class HomePage extends ConsumerStatefulWidget {
	const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getCategoriesProvider);
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        title: Image.asset('assets/appBarLogo.png',
          height: MediaQuery.of(context).padding.top - 18,
        ),
        centerTitle: true,
        backgroundColor: CsColors.cs.accentColor,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.cart, color: Colors.white,),
            onPressed: (){
            }
          ),
          SizedBox(width: 8),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: tabIndex - 1,
          children: [ 
            MainPageN(),
            UserInfoPage()
          ],
        ),
      ),
      drawer: drawerCategory(context: context, ref: ref),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (newValue){
            setState(() {
              if(newValue == 0){
                _drawerKey.currentState?.openDrawer();
              } else {
                tabIndex = newValue;
              }
            });
          },
          backgroundColor: CsColors.cs.accentColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill), label: ""),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_fill), label: ""),
          ],
        ),
      ),
    );
  }
}
