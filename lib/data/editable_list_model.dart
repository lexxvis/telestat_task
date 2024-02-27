import 'package:equatable/equatable.dart';

class EditableListModel extends Equatable {
  final String title;
  final String description;
  final String hour;
  final String minutes;

  const EditableListModel(
      {required this.title,
      required this.description,
      required this.hour,
      required this.minutes});

  @override
  List<Object?> get props => [title, description, hour, minutes];
}
