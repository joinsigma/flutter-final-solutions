import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/likes/likes_bloc.dart';
import 'package:travel_app/ui/likes/widgets/like_card.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class LikesScreen extends StatefulWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  late LikesBloc _likesBloc;

  @override
  void initState() {
    _likesBloc = kiwi.KiwiContainer().resolve<LikesBloc>();
    _likesBloc.add(LoadLikes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _likesBloc,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 20, bottom: 8.0),
              child: Text(
                'Your Likes',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            // Divider(),
            BlocBuilder<LikesBloc, LikesState>(
              builder: (context, state) {
                if (state is LikesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LikesLoadSuccess) {
                  return Expanded(
                    child: state.packages.isEmpty
                        ? const Center(
                            child: Text(
                              'You have no likes at the moment, \n keep exploring',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.packages.length,
                            itemBuilder: (context, index) {
                              return LikeCard(
                                package: state.packages[index],
                              );
                            },
                          ),
                  );
                } else {
                  ///Todo: Implement better error message.
                  return const Center(
                    child: Text('Error'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
