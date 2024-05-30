import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tasky/features/feature_home/data/model/profile_model.dart';
import 'package:tasky/features/feature_home/data/remote/api_provider.dart';
import 'package:tasky/features/feature_home/presentation/bloc/profile_cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile_screen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).fetchUserProfile();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Profile',style:textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold) ,),
        leading: IconButton(
          icon: Icon(IconlyBold.arrow_left),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {

          if(state.profileStatus is ProfileLoading){
            return Center(child: CircularProgressIndicator(),);
          }

          if(state.profileStatus is ProfileCompleted){
            ProfileCompleted profile = state.profileStatus as ProfileCompleted;
            ProfileModel model = profile.profileModel;

            return Padding(
              padding: const EdgeInsets.all( 24),
              child: Column(children: [
                ProfileItem(textTheme,'NAME',model.displayName!),
                ProfileItem(textTheme,'PHONE',model.username!),
                ProfileItem(textTheme,'LEVEL',model.level!),
                ProfileItem(textTheme,'YEARS OF EXPERIENCE',model.experienceYears.toString()),
                ProfileItem(textTheme,'LOCATION',model.address!),
              ],),
            );

          }

          if(state.profileStatus is ProfileFailed){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.purple[400],
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

  }
),
    );
  }

  Container ProfileItem(TextTheme textTheme,String title,String subTitle) {
    return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 15),
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(title,style: textTheme.bodyMedium?.copyWith(color: Color(0x2F2F2F66).withOpacity(0.4)),),
            Text(subTitle,style: textTheme.titleLarge?.copyWith(color: Colors.grey[600],fontWeight: FontWeight.bold),),
          ],),
        );
  }
}
