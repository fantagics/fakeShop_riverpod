import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../resources/color_asset/colors.dart';
import '../../service/procucts_provider.dart';
import '../../model/translation_ko.dart';

drawerCategory({required BuildContext context, required WidgetRef ref}){
  final categories = ref.watch(getCategoriesProvider);
  
  return Drawer(
    backgroundColor: CsColors.cs.accentColor,
    child: SizedBox(
      height: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.only(
          left: 8, right: 18
        ),
        child: categories.when(
          data: (data){
            return ListView.builder(
              itemCount: data.length + 2,
              itemBuilder: (context, index) {
                if(index == 0){
                  return Container(
                    padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 10, 16, 40),
                    child: Center(
                      child: Text('카테고리',
                        style: GoogleFonts.notoSans(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  );
                } else if(index == 1){
                  return Card(
                    color: Colors.white.withOpacity(0.9),
                    child: ListTile(
                      title: Text("전체보기",
                        style: GoogleFonts.notoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CsColors.cs.darkAccentColor
                          ),
                      ),
                      onTap: (){
                        ref.read(sortTypeProvider.notifier).update((state) => SortType.recent);
                        ref.read(selectedCategoryProvider.notifier).update((state) => 'all');
                        ref.read(searchTextProvider.notifier).update((state) => '');
                        Navigator.pushNamed(context, '/productsList');
                      },
                    ),
                  );
                } else{
                  return Card(
                    color: Colors.white.withOpacity(0.9),
                    child: ListTile(
                      title: Text(CategoryKo[data[index-2]] ?? data[index-2],
                        style: GoogleFonts.notoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CsColors.cs.darkAccentColor
                          ),
                      ),
                      onTap: (){
                        ref.read(sortTypeProvider.notifier).update((state) => SortType.recent);
                        ref.read(selectedCategoryProvider.notifier).update((state) => ref.watch(categoriesProvider)[index-2]);
                        ref.read(searchTextProvider.notifier).update((state) => '');
                        Navigator.pushNamed(context, '/productsList');
                      },
                    ),
                  );
                }
              },
            );
          }, 
          error: (e, _){
            return drawerEntire(context: context, ref: ref);
          },
          loading: () => Container()
        ),
        
      ),
    )
  );
}

drawerEntire({required BuildContext context, required WidgetRef ref}){
  return ListView.builder(
    itemCount: 2,
    itemBuilder: (context, index) {
      if(index == 0){
        return Container(
          padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 10, 16, 40),
          child: Center(
            child: Text('카테고리',
              style: GoogleFonts.notoSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
        );
      } else {
        return Card(
          color: Colors.white.withOpacity(0.9),
          child: ListTile(
            title: Text("전체보기",
              style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CsColors.cs.darkAccentColor
                ),
            ),
            onTap: (){
              ref.read(sortTypeProvider.notifier).update((state) => SortType.recent);
              ref.read(selectedCategoryProvider.notifier).update((state) => 'all');
              ref.read(searchTextProvider.notifier).update((state) => '');
              Navigator.pushNamed(context, '/productsList');
            },
          ),
        );
      }
    },
  );
}
