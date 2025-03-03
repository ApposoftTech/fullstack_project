import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  AuthAuthenticated({required this.token});

  @override
  List<Object?> get props => [token];
}

class AuthRegistered extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
