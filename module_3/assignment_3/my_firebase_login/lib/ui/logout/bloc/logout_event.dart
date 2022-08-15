import 'package:equatable/equatable.dart';

/// Todo 16: Prepare bloc event for logout_bloc
///   - event: [TriggerLogout]

abstract class LogoutEvent extends Equatable {}

class TriggerLogout extends LogoutEvent {
  @override
  List<Object?> get props => [];
}