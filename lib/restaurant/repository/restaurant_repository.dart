import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../model/restaurant_detail_model.dart';
import '../model/restaurant_model.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
    (ref){
      // provider 안에서는 watch를 사용하는 것이 좋다.
      final dio = ref.watch(dioProvider);

      final repository = RestaurantRepository(dio, baseUrl: 'http://$serverIp/restaurant');

      return repository;
    }
);

@RestApi()
abstract class RestaurantRepository {
  // http://$serverIp/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl})
  = _RestaurantRepository;


  @GET('/')
  @Headers({
    'accessToken' : 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  @GET('/{id}')
  @Headers({
    'accessToken' : 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });


}