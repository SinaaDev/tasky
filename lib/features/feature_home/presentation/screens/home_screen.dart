import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/models/TokenModel.dart';
import 'package:tasky/features/feature_auth/presentation/bloc/auth_cubit.dart';
import 'package:tasky/features/feature_auth/presentation/screens/sign_in_screen.dart';
import 'package:tasky/features/feature_create/presentation/bloc/create_cubit.dart';
import 'package:tasky/features/feature_create/presentation/screens/create_screen.dart';
import 'package:tasky/features/feature_home/presentation/screens/profile_screen.dart';
import 'package:tasky/features/feature_home/presentation/screens/widgets/task_item.dart';

import '../../data/model/AllTaskModel.dart';
import '../bloc/home_cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_screen';

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = true;

  int defaultChoiceIndex = 0;

  final List<String> _choiceList = [
    'All',
    'In progress',
    'Waiting',
    'Finished',
  ];
  late bool activeSwitch;

  List<AllTaskModel> tasksList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeCubit>(context).fetchAllTasks();
    activeSwitch = false;
    print('init state');
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Logo',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          }, icon: const Icon(Iconsax.profile_circle)),
          IconButton(onPressed: () {
            BlocProvider.of<AuthCubit>(context).logout();
            Navigator.pushReplacementNamed(context, SignInScreen.routeName);
          }, icon: const Icon(Iconsax.logout)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          activeSwitch = false;
         return BlocProvider.of<HomeCubit>(context).fetchAllTasks();},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'My Tasks',
                style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              BlocBuilder<HomeCubit, HomeState>(
                // buildWhen: (previous, current) {
                //   if(current.homeStatus is HomeCompleted){
                //     return true;
                //   }
                //   return false;
                // },
                builder: (context, state) {


                  return Row(
                    children: [
                      Wrap(
                        spacing: 8,
                        children: List.generate(
                          _choiceList.length,
                          (index) => ChoiceChip(
                            backgroundColor: primaryColor.withOpacity(0.4),
                            showCheckmark: false,
                            selectedColor: primaryColor,
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: const BorderSide(color: Colors.white)),
                            // color: MaterialStatePropertyAll(primaryColor.withOpacity(0.2)),
                            label: Text(_choiceList[index]),
                            selected: defaultChoiceIndex == index,
                            onSelected: (value) {
                              setState(
                                () {
                                  defaultChoiceIndex =
                                      value ? index : defaultChoiceIndex;


                                  if(state.homeStatus is HomeCompleted && activeSwitch){
                                    HomeCompleted homeCompleted =

                                    state.homeStatus as HomeCompleted;
                                  switch (index) {
                                    case 0:
                                      tasksList = homeCompleted.allTaskList;
                                      break;
                                    case 1:
                                      tasksList = homeCompleted.allTaskList
                                          .where((element) =>
                                              element.status == 'inprogress')
                                          .toList();
                                      break;
                                    case 2:
                                      tasksList = homeCompleted.allTaskList
                                          .where((element) =>
                                              element.status == 'waiting')
                                          .toList();
                                      break;
                                    case 3:
                                      tasksList = homeCompleted.allTaskList
                                          .where((element) =>
                                              element.status == 'finished')
                                          .toList();
                                      break;}
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {


                    if (state.homeStatus is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.homeStatus is HomeCompleted) {
                      if(!activeSwitch){
                      HomeCompleted homeCompleted =
                          state.homeStatus as HomeCompleted;
                     tasksList = homeCompleted.allTaskList;
                     activeSwitch = true;
                      }

                      if(tasksList.isNotEmpty){

                      return ListView.builder(
                          itemCount: tasksList.length,
                          itemBuilder: (ctx, i) {
                            return TaskItem(
                                id: tasksList[i].id!,
                                image: tasksList[i].image!,
                                title: tasksList[i].title!,
                                desc: tasksList[i].desc!,
                                priority: tasksList[i].priority!,
                                status: tasksList[i].status!,
                                createdAt: tasksList[i].createdAt!);
                          });}else{
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.hourglass_empty,
                                size: 60,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'No Task Available',
                                style: textTheme.titleMedium,
                              )
                            ],
                          ),
                        );
                      }
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
                            const SizedBox(
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
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: 'qr_code',
                onPressed: () {
                  showDialog(context: context, builder: (_)=>AlertDialog(
                    title: SizedBox(
                        height: 250,
                        width: 250,
                        child: AspectRatio(
                            aspectRatio: 1/1,
                            child: QrImageView(data: "i didn't know what to link here ",version: QrVersions.auto,))),
                  ));
                },
                backgroundColor: primaryColor.withOpacity(0.2),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                foregroundColor: primaryColor,
                child: const Icon(CupertinoIcons.qrcode),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: 64,
            height: 64,
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: 'create',
                onPressed: () {
                  Navigator.pushNamed(context, CreateScreen.routeName);
                },
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                foregroundColor: Colors.white,
                child: const Icon(CupertinoIcons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
