part of 'create_cubit.dart';

abstract class CreationStatus{}

class CreationInitial extends CreationStatus{}

class CreationLoading extends CreationStatus{}

class CreationCompleted extends CreationStatus{}

class CreationError extends CreationStatus{}