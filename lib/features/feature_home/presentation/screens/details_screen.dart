import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/params/edit_task_params.dart';
import 'package:tasky/core/utils/custom_snackbar.dart';
import 'package:tasky/features/feature_home/data/model/OneTaskModel.dart';
import 'package:tasky/features/feature_home/data/remote/api_provider.dart';
import 'package:tasky/features/feature_home/presentation/bloc/home_cubit/home_cubit.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details_screen';

  DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String date = '';
  String? priority;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate:
          DateTime.now().add(Duration(days: 365 * 20)), // 20 years from now
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        date = picked.toString().split(' ').first; // Format the date string
      });
    }
  }

  String text =
      '''This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.''';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Task Details',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(IconlyBold.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  position: PopupMenuPosition.under,
                  icon: Icon(CupertinoIcons.ellipsis_vertical),
                  onSelected: (String result) {
                    // Handle the selection
                    switch (result) {
                      case 'Save':
                        if (state.editStatus is EditCompleted) {
                          var task =
                              BlocProvider.of<HomeCubit>(context, listen: false)
                                  .task!;

                          EditTaskParams params = EditTaskParams(
                              image: task.image!,
                              title: task.title!,
                              desc: task.desc!,
                              priority: task.priority!,
                              status: task.status!,
                              user: task.user!);

                          print('new saved details: '+task.priority! +' '+ task.status!);

                          BlocProvider.of<HomeCubit>(context, listen: false)
                              .editTask(params);

                          CustomSnackBar(
                                  contentText: 'Saved',
                                  backgroundColor: Colors.green)
                              .show(context);
                          break;
                        }
                        if(state.editStatus is EditFailed){
                          CustomSnackBar(contentText: 'Failed', backgroundColor: Colors.red);
                          break;
                        }
                      case 'Delete':
                        print('Delete selected');
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Save',
                      child: Text(
                        'Save',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state.detailStatus is DetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.detailStatus is DetailCompleted) {
            DetailCompleted detailCompleted =
                state.detailStatus as DetailCompleted;
            OneTaskModel model = detailCompleted.oneTaskModel;

            DateTime dateTime = DateTime.parse(model.createdAt!);
            String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 220,
                      child: Image.asset(
                        'assets/images/task.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      model.title!,
                      style: textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      model.desc!,
                      textAlign: TextAlign.left,
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor.withOpacity(0.2)),
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(text: formattedDate),
                        // Initialize with the current date
                        decoration: InputDecoration(
                          // fillColor: primaryColor.withOpacity(0.2),
                          // filled: true,
                          // isDense: true,
                          border: InputBorder.none,
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: primaryColor.withOpacity(0.2))),
                          // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: primaryColor.withOpacity(0.2))),
                          hintText: 'choose due date...',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Iconsax.calendar_1,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor.withOpacity(0.2)),
                      child: DropdownButtonFormField<String>(
                        icon: Icon(
                          IconlyBold.arrow_down_2,
                          color: primaryColor,
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
                        value: model.status,
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              model.status!,
                              style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            model.status = newValue!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                        items: <String>['waiting', 'inprogress', 'finished']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor.withOpacity(0.2)),
                      child: DropdownButtonFormField<String>(
                        icon: Icon(
                          IconlyBold.arrow_down_2,
                          color: primaryColor,
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
                        value: model.priority,
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.flag,
                              size: 30,
                              color: primaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              model.priority!,
                              style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            model.priority = newValue!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                        items: <String>['low', 'medium', 'high']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 16),
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: GestureDetector(
                        onTap: () {
                          print(model.title! +
                              ' ' +
                              model.desc! +
                              ' ' +
                              model.createdAt! +
                              ' ' +
                              model.status! +
                              ' ' +
                              model.priority!);
                          var task =
                          BlocProvider.of<HomeCubit>(context, listen: false)
                              .task!;

                          EditTaskParams params = EditTaskParams(
                              image: task.image!,
                              title: task.title!,
                              desc: task.desc!,
                              priority: task.priority!,
                              status: task.status!,
                              user: task.user!);
                          HomeApiProvider().sendEditRequest(params);
                          print('new saved details: '+task.priority! +' '+ task.status!);

                        },
                        child: QrImageView(
                          padding: EdgeInsets.all(24),
                          data: model.id!,
                          version: QrVersions.auto,
                          // size: 200.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }

          if (state.homeStatus is HomeFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No Internet Connection',
                    style: textTheme.titleMedium,
                  )
                ],
              ),
            );
          }

          return Container();
        }));
  }
}
