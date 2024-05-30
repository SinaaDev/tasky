class EditTaskParams {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;

  EditTaskParams({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
  });
}
