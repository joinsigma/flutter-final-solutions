import 'package:equatable/equatable.dart';
import 'package:my_restaurant/data/model/review.dart';

abstract class ReviewState extends Equatable {}

class ReviewInitial extends ReviewState {
  @override
  List<Object?> get props => [];
}

class ReviewLoading extends ReviewState {
  @override
  List<Object?> get props => [];
}

class GetReviewSuccessful extends ReviewState {
  final List<Review> reviews;

  GetReviewSuccessful(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

class GetReviewFailed extends ReviewState {
  final String errorMsg;

  GetReviewFailed(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}