import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/products.dart';
import '../../service/procucts_provider.dart';
import 'subview/banner_autoslider.dart';
import 'subview/recommends_listtile.dart';
import '../subviews/circle_progress_indicator_widget.dart';

class MainPageN extends ConsumerStatefulWidget {
	const MainPageN({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageN();
}

class _MainPageN extends ConsumerState<MainPageN> {
  @override
  Widget build(BuildContext context) {
    final categoies = ref.watch(categoriesProvider);
    final state = ref.watch(recommedItemProvider);
    double imgLength = MediaQuery.of(context).size.width / 5;
    return Scaffold(
      body: state.when(
        data: (data){
          return RefreshIndicator(
            onRefresh: () async {
              // ref.invalidate(getCategoriesProvider);
              ref.invalidate(recommedItemProvider);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BannerAutoSlider(),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: ((imgLength + 101) * 4) + 60,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: categoies.length,
                      itemBuilder: (context, index) {
                        String category = categoies[index];
                        List<Product> products = data[category] ?? [];
                        return products.length != 3 ? Container() : RecommendsListTile(category: category, products: products, imgLength: imgLength);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }, 
        error: (error, stackTrace){
          print('ERROR : ${error} \n${stackTrace}');
          return Container();
        }, 
        loading: (){
          return CircleProgerssIndicator();
        }
      ),
    );
  }
}
