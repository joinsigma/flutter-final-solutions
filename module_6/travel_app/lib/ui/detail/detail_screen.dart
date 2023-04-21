import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/ui/detail/detail_bloc.dart';

import '../../data/model/detail_package.dart';
import '../confirm/booking_confirmation_screen.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final String title;
  final int price;
  const DetailScreen(
      {Key? key, required this.id, required this.title, required this.price})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailBloc _detailBloc;
  @override
  void initState() {
    _detailBloc = kiwi.KiwiContainer().resolve<DetailBloc>();
    _detailBloc.add(LoadPackageDetail(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _detailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailBloc,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            widget.title,
            maxLines: 2,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingConfirmationScreen(
                    packageId: widget.id,
                    pricePerPax: widget.price,
                  ),
                ),
              );
            },
            child: const Text(
              'Start Booking',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )),
        body: BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
          if (state is DetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailLoadSuccess) {
            return ListView(
              children: [
                _buildPhotoSection(state.package.imgUrls),

                ///Package title, travel company and review section
                ListTile(
                  subtitle: Text(state.package.provider),
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      '${state.package.rating}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                ///Details section
                ListTile(
                  subtitle: const Text('Price per person'),
                  title: Text(
                    'RM ${state.package.price}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                ListTile(
                    leading: const Icon(Icons.place_outlined),
                    title: Text(
                      state.package.location,
                      style: const TextStyle(fontSize: 13),
                    )),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text(
                    state.package.description,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: Text(
                    state.package.mealInfo,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),

                ///Description
                const Divider(),
                ExpansionTile(
                  title: const Text(
                    'Itinerary Details',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  // subtitle: const Text('Eagle Feeding'),

                  ///Remove border
                  shape: Border.all(color: Colors.transparent),
                  children: _buildItineraryDetails(state.package.itineraries),
                ),
                const Divider(),

                ///Facilities
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tags',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                _buildTagsSection(state.package.tags),
              ],
            );
          }

          ///Todo: Implement better error message.
          else {
            return const Text('Error');
          }
        }),
      ),
    );
  }

  ///Photo section
  Widget _buildPhotoSection(List<String> images) {
    ///List to be passed to children parameter of PageView
    List<Widget> networkImages = [];
    for (var image in images) {
      networkImages.add(
        Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PageView(
            children: networkImages,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30.0)),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30.0)),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///ListTiles for itinerary details section
  List<Widget> _buildItineraryDetails(List<Itinerary> itineraries) {
    List<Widget> itineraryList = [];

    for (var itinerary in itineraries) {
      itineraryList.add(
        ListTile(
          isThreeLine: true,
          leading: const Icon(
            Icons.place,
            color: Colors.orangeAccent,
          ),
          title: Text(itinerary.title),
          subtitle: Text(itinerary.description),
        ),
      );
    }

    return itineraryList;
  }

  ///Tags section
  Widget _buildTagsSection(List<String> tags) {
    List<Widget> chipTags = [];

    for (var tag in tags) {
      chipTags.add(
        Chip(
          backgroundColor: Colors.orangeAccent,
          label: Text(
            tag,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Wrap(spacing: 5.0, children: chipTags
          // children: const [
          //   Chip(
          //     backgroundColor: Colors.orangeAccent,
          //     label: Text(
          //       'Island Hopping',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          //   Chip(
          //     backgroundColor: Colors.orangeAccent,
          //     label: Text(
          //       'Eagle Feeding',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          //   Chip(
          //     backgroundColor: Colors.orangeAccent,
          //     label: Text(
          //       'Island Tour',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          //   Chip(
          //     backgroundColor: Colors.orangeAccent,
          //     label: Text(
          //       'Pristine Beach',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ],
          ),
    );
  }

  ///Todo: Remove this.
  // Widget _buildBookingInfo() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Row(
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text('Start'),
  //                 Text(
  //                   'Mon, 19 Dec',
  //                   style: TextStyle(color: Colors.orange),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(
  //               width: 100,
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text('End'),
  //                 Text(
  //                   'Tue, 20 Dec',
  //                   style: TextStyle(color: Colors.orange),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.only(left: 8.0, top: 8.0),
  //         child: Text('No of guests'),
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
  //         child: Text(
  //           '3 adults',
  //           style: TextStyle(color: Colors.orange),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget _buildItineraryDetails() {
  //   return ExpansionTile(
  //     title: const Text(
  //       'Day 1',
  //     ),
  //     subtitle: const Text('Eagle Feeding'),
  //
  //     ///Remove border
  //     shape: Border.all(color: Colors.transparent),
  //     children: const [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 13.0),
  //         child: Text(
  //             'Situated in Pantain Cenang, 1.3km from Cenang beach, Perdana Serviced Appartment & resorts features accomodation with free bikes, free private parknig, an outdoor simming pol and a shared louge. Boasting a shared kitchen, this property also provides guests with a terrace. The property offers car hire and feature a garden and berceue.'),
  //       )
  //     ],
  //   );
  // }
}
