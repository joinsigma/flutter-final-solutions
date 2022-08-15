import 'package:bloc/bloc.dart';
import 'package:my_restaurant/data/network/exceptions.dart';
import 'package:my_restaurant/data/repository/restaurant_repository.dart';
import 'package:my_restaurant/ui/reviews/bloc/review_event.dart';
import 'package:my_restaurant/ui/reviews/bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final RestaurantRepository _restaurantRepository;

  // Initial state: ReviewInitial
  ReviewBloc(this._restaurantRepository) : super(ReviewInitial()) {
    on<TriggerGetReview>(_onTriggerGetReview);
  }

  // Handle get restaurant review
  void _onTriggerGetReview(
    TriggerGetReview event,
    Emitter<ReviewState> emit,
  ) async {
    try {
      emit(ReviewLoading());
      final reviews = await _restaurantRepository.getRestaurantReviewById(
        event.restaurantId,
      );
      emit(GetReviewSuccessful(reviews));
    } on GetRestaurantReviewException catch (exception) {
      emit(GetReviewFailed(exception.errorMsg));
    }
  }
}
