import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_restaurant/data/model/restaurant_details.dart';
import 'package:my_restaurant/data/model/review.dart';
import 'package:my_restaurant/ui/details/bloc/restaurant_details_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_restaurant/ui/details/bloc/restaurant_details_event.dart';
import 'package:my_restaurant/ui/details/bloc/restaurant_details_state.dart';
import 'package:my_restaurant/ui/reviews/bloc/review_bloc.dart';
import 'package:my_restaurant/ui/reviews/bloc/review_event.dart';
import 'package:my_restaurant/ui/reviews/bloc/review_state.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final String restaurantId;
  const RestaurantDetailsScreen({
    required this.restaurantId,
    super.key,
  });

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  late RestaurantDetailsBloc _restaurantDetailsBloc;
  late ReviewBloc _reviewBloc;

  @override
  void initState() {
    _restaurantDetailsBloc =
        kiwi.KiwiContainer().resolve<RestaurantDetailsBloc>();
    _restaurantDetailsBloc.add(
      TriggerGetRestaurantDetails(widget.restaurantId),
    );
    _reviewBloc = kiwi.KiwiContainer().resolve<ReviewBloc>();
    _reviewBloc.add(TriggerGetReview(widget.restaurantId));
    super.initState();
  }

  @override
  void dispose() {
    _restaurantDetailsBloc.close();
    _reviewBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _restaurantDetailsBloc),
        BlocProvider(create: (context) => _reviewBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant Details'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 24.0,
          ),
          child: BlocBuilder<RestaurantDetailsBloc, RestaurantDetailsState>(
            builder: (context, state) {
              if (state is RestaurantDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RestaurantDetailsFailed) {
                return Center(
                  child: Text(state.errorMsg),
                );
              } else if (state is RestaurantDetailsSuccessful) {
                RestaurantDetails restaurantDetails = state.restaurantDetails;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Info
                    ListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      leading: CircleAvatar(
                        backgroundImage: restaurantDetails.imageUrl.isNotEmpty
                            ? NetworkImage(
                                restaurantDetails.imageUrl,
                              )
                            : null,
                      ),
                      title: Text(restaurantDetails.name),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${restaurantDetails.rating} \u2605'),
                          Text('${restaurantDetails.reviewCount} reviews'),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 16.0),

                    // Opening now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Opening now: ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        restaurantDetails.isClosed
                            ? const Text('NO')
                            : const Text('Yessssssssssssssssssss'),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Webpage url
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Webpage Url: ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          restaurantDetails.webpageUrl,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Phone
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contacts: ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          (restaurantDetails.displayPhone.isEmpty
                              ? '-'
                              : restaurantDetails.displayPhone),
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Address
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Address: ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        ...List.generate(
                          restaurantDetails.displayAddress.length,
                          (index) => Text(
                            restaurantDetails.displayAddress[index],
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Reviews
                    const Text(
                      'Reviews: ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    BlocBuilder<ReviewBloc, ReviewState>(
                      builder: (context, state) {
                        if (state is ReviewLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetReviewFailed) {
                          return Center(
                            child: Text(state.errorMsg),
                          );
                        } else if (state is GetReviewSuccessful) {
                          List<Review> reviews = state.reviews;
                          return Expanded(
                            child: ListView.builder(
                              primary: false,
                              // shrinkWrap: true,
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        (reviews[index].createdUser.imageUrl !=
                                                null)
                                            ? NetworkImage(
                                                reviews[index]
                                                    .createdUser
                                                    .imageUrl!,
                                              )
                                            : null,
                                  ),
                                  title: Text(reviews[index].createdUser.name!),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${reviews[index].rating} / 5.0 \u2605'),
                                      Text(
                                          '${reviews[index].createdTime.year}-${reviews[index].createdTime.month}-${reviews[index].createdTime.day}')
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
