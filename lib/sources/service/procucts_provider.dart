import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/request_result.dart';
import '../model/products.dart';
import '../network/network_service.dart';

final eventsImgProvider = Provider<List<String>>((ref) => [
  'assets/event_0.png',
  'assets/event_1.png',
  'assets/event_2.png',
]);

final categoriesProvider = StateProvider<List<String>>((ref)=>[]);
final getCategoriesProvider = FutureProvider<List<String>>((ref) async{ //-> StateProvider ?
  final ns = NetworkService();
  final categoryResult = await ns.getCategories();
  switch(categoryResult.result){
    case Result.success:
      List<String> value = categoryResult.data as List<String>;
      ref.read(categoriesProvider.notifier).update((state) => value);
      return value;
    case Result.failed:
      throw Exception(categoryResult.data);
  }
});

final recommedItemProvider = FutureProvider<Map<String,List<Product>>>((ref) async{
  final ns = NetworkService();
  final categories = ref.watch(categoriesProvider);
  final itemsResult = await ns.getRecommendItemsEachCategory(categories as List<String>);
  switch(itemsResult.result){
    case Result.success:
      return itemsResult.data as Map<String,List<Product>>;
    case Result.failed:
      throw Exception(itemsResult.data);
  }
});


final selectedCategoryProvider = StateProvider<String>((ref) => 'all');
final searchTextProvider = StateProvider<String>((ref) => '');
final sortTypeProvider = StateProvider<SortType>((ref) => SortType.recent);
//pagination
// final addedCountProvider = Provider<int>((ref) => 8);
// final showProducts = StateNotifierProvider<MoreProducts, List<Product>>((ref){
//   return MoreProducts(ref);
// });

// class MoreProducts extends StateNotifier<List<Product>>{
//   MoreProducts(this.ref) : super([]);
//   StateNotifierProviderRef<MoreProducts, List<Product>> ref;

//   void addMoreItem(){
//     print("addMoreItem");
//     final receivedProducts = ref.watch(recProducts);
//     final addCount = ref.watch(addedCountProvider);
//     if(state.length < receivedProducts.length){
//       if(receivedProducts.length - state.length < addCount){
//         state.addAll(receivedProducts.sublist(state.length, receivedProducts.length));
//       } else {
//         state.addAll(receivedProducts.sublist(state.length, state.length + addCount));
//       }
//     }
//     print("show length: ${state.length}");
//   }
// }

final recProducts = StateProvider<List<Product>>((ref)=>[]);
final productsRef = FutureProvider<List<Product>>((ref) async{
  final ns = NetworkService();
  final selected = ref.watch(selectedCategoryProvider);
  final searchText = ref.watch(searchTextProvider);
  final sortType = ref.watch(sortTypeProvider);
  if(selected == 'all'){
    final res = await ns.getAllProducts();
    switch(res.result){
      case Result.success:
        final initalProducts = res.data as List<Product>;
        final searchedProducts = productsFilter(initalProducts,searchText);
        final sortedProducts = productssSorter(searchedProducts,sortType);
        ref.read(recProducts.notifier).update((state) => sortedProducts);
        return sortedProducts;
      case Result.failed:
        throw Exception(res.data);
    }
  } else {
    final res = await ns.getProductsOf(category: selected);
    switch(res.result){
      case Result.success:
        final initalProducts = res.data as List<Product>;
        final searchedProducts = productsFilter(initalProducts,searchText);
        final sortedProducts = productssSorter(searchedProducts,sortType);
        ref.read(recProducts.notifier).update((state) => sortedProducts);
        return sortedProducts;
      case Result.failed:
        throw Exception(res.data);
    }
  }
});

List<Product> productsFilter(List<Product> items, String searchText){
  return searchText.isEmpty ? items : items.where((e) => e.title.contains(searchText)).toList();
}
List<Product> productssSorter(List<Product> items, SortType type){
  switch(type){
    case SortType.recent:
      items.sort((a, b) => b.id.compareTo(a.id));
      break;
    case SortType.highCost:
      items.sort((a, b) => b.price.compareTo(a.price));
      break;
    case SortType.lowCost:
      items.sort((a, b) => a.price.compareTo(b.price));
      break;
    case SortType.highRate:
      items.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
      break;
    case SortType.highSales:
      items.sort((a, b) => b.rating.count.compareTo(a.rating.count));
      break;
  }
  return items;
}


enum SortType{
  recent(0,'recent'),
  highCost(1,'highCost'),
  lowCost(2,'lowCost'),
  highRate(3,'highRate'),
  highSales(4,'highSales');

  const SortType(this.idx, this.str);
  final int idx;
  final String str;
  
  factory SortType.getByIndex(int index){
    return SortType.values.firstWhere((element) => element.idx == index,
    orElse: () => SortType.recent);
  }
}