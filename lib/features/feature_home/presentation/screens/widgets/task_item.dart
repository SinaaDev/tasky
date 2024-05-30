import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasky/features/feature_create/presentation/screens/create_screen.dart';
import 'package:tasky/features/feature_home/data/remote/api_provider.dart';
import 'package:tasky/features/feature_home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:tasky/features/feature_home/presentation/screens/details_screen.dart';

class TaskItem extends StatelessWidget {

  final String id;
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  // final String user;
  final String createdAt;
  // final String updatedAt;
  // final num v;

   TaskItem({super.key, required this.id, required this.image, required this.title, required this.desc, required this.priority, required this.status, required this.createdAt});


   Color priorityColor(){
     Color color;
     switch(priority){
       case 'low':
         color = Color(0xFF0087FF);
         break;
       case 'medium':
         color = Color(0xFF5F33E1);
         break;
       case 'high':
         color = Color(0xFFFF7D53);
         break;
       default: color = Colors.black;
     }
     return color;
   }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;
    final width = MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.parse(createdAt);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return InkWell(
      onTap: (){
        BlocProvider.of<HomeCubit>(context).fetchOneTask(id);
        Navigator.pushNamed(context, DetailsScreen.routeName);
      },
      child: Container(
        margin: EdgeInsets.only(top: 12),
        // color: Colors.red,
        height: 80,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          SizedBox(
            width: width*0.17,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Image.asset('assets/images/task.png',fit: BoxFit.cover,width: 64,height: 64,),
            ],),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: width*0.64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Flexible(child: Text(title,style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                Container(
                  width: 55,
                  height: 22,
                  decoration: BoxDecoration(color: Color(0xFFFFE4F2),borderRadius: BorderRadius.circular(5)),
                  child: Center(child: Text(status,maxLines: 1,style: textTheme.bodySmall?.copyWith(color: Color(0xFFFF7D53)),)),
                )
              ],),
              Row(children: [
                Flexible(child: Text(desc,overflow: TextOverflow.ellipsis,style: textTheme.bodyMedium?.copyWith(color: Colors.grey[700],),)),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Icon(CupertinoIcons.flag,size: 16,color: priorityColor(),),
                SizedBox(width: 4),
                Text(priority,style: textTheme.bodySmall?.copyWith(color: priorityColor(),fontWeight: FontWeight.w500),),
                Spacer(),
                Text(formattedDate,style: textTheme.bodySmall?.copyWith(color: Colors.grey[700]),),
              ],)
            ],),
          ),
            SizedBox(width: 10),
          Flexible(
            child: SizedBox(
              width: width*0.07,
              child: Column(
                children: [
                Icon(Icons.more_vert,size:24 ,)
              ],),
            ),
          )
        ],),
      ),
    );
  }
}
