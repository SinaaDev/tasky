import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/params/task_param.dart';
import 'package:tasky/core/utils/custom_snackbar.dart';
import 'package:tasky/core/widgets/app_button.dart';
import 'package:tasky/features/feature_create/presentation/bloc/create_cubit.dart';
import 'package:tasky/features/feature_home/presentation/screens/home_screen.dart';

class CreateScreen extends StatefulWidget {
  static const routeName = '/create_screen';
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  String date = '';
  String? path;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String? priority;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image!= null) {
      // Process the image file here
      print(image.path); // For demonstration purposes
      path = image.path;
      setState(() {});
    } else {
      print('No image selected.');
    }
  }

   Future<void> createTask()async{
    print('path: ${path}');
    print('title: ${titleController.text}');
    print('desc: ${descController.text}');
    print('priority: ${priority}');
    print('date: ${date}');
    TaskParam newTask = TaskParam(path: path??'', title: titleController.text, desc: descController.text, priority: priority?? 'low', dueDate: date);
    await BlocProvider.of<CreateCubit>(context).addTask(newTask).then((value) => {
    CustomSnackBar(contentText: 'Task Added',backgroundColor: Colors.green).show(context),
      Navigator.pop(context),
      Navigator.pushReplacementNamed(context, HomePage.routeName),

    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365 * 20)), // 20 years from now
    );

    if (picked!= null && picked!= DateTime.now()) {
      setState(() {
        date = picked.toString().split(' ').first; // Format the date string
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Task Details',style:textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold) ,),
        leading: IconButton(
          icon: const Icon(IconlyBold.arrow_left),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _pickImage,
              child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              color: primaryColor,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(path == null ? Icons.add_photo_alternate_outlined : Icons.photo_outlined,color: primaryColor,size: 30,),
                    const SizedBox(width: 10),
                    Text(path == null ?'Add Img':'Img Added',style: textTheme.titleLarge?.copyWith(color: primaryColor),)
                  ],),
                ),
              ),
                        ),
            ),
            const SizedBox(height: 16),
            Text('Task Title',style: TextStyle(color: Colors.grey[700]),),
            const SizedBox(height: 8),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.grey)),
                hintText: 'Enter title here...',
              ),
            ),
              const SizedBox(height: 16),
              Text('Task Description',style: TextStyle(color: Colors.grey[700]),),
              const SizedBox(height: 8),
              TextFormField(
                controller: descController,
                maxLines: 7,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.grey)),
                  hintText: 'Enter description here...',
                ),
              ),
              const SizedBox(height: 16),
              Text('Priority',style: TextStyle(color: Colors.grey[700]),),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  color: primaryColor.withOpacity(0.3)
                ),
                child: DropdownButtonFormField<String>(
                  icon: Icon(IconlyBold.arrow_down_2,color: primaryColor,),
                  decoration: const InputDecoration(border: InputBorder.none),
                  value: priority,
                  hint: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.flag,size: 30,color: primaryColor,),
                      const SizedBox(width: 10),
                      Text(
                        'Choose Priority',
                        style: textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold,color: primaryColor),
                      ),
                    ],
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      priority = newValue!;
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
              const SizedBox(height: 16),
              Text('Due Date',style: TextStyle(color: Colors.grey[700]),),
              const SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: date), // Initialize with the current date
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.grey)),
                hintText: 'choose due date...',
                suffixIcon: IconButton(
                  icon: Icon(Iconsax.calendar_1,color: Theme.of(context).primaryColor,size: 30,),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
              const SizedBox(height: 28),
              AppButton(title: 'Add Task', onPressed: createTask ,)
          ],),
        ),
      ),
    );
  }
}
