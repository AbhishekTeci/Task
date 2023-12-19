import 'package:flutter/material.dart';

class EmployeeProfile extends StatelessWidget {
  String? image;
  String? name;
  String? salary;
  String? age;

  EmployeeProfile(
      {super.key,
      required this.image,
      required this.name,
      required this.salary,
      required this.age});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              image != null && image != ''
                  ? SizedBox(
                  height: 50, width: 50, child: Image.network(image!))
                  : SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/images/profile.jpg')),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [userData(name,'Name'), userData(salary,'Salary'), userData(age,'Age')],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget userData(String? data,String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          '$value : ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        data != null
            ? Text(
                data,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 14,
                ),
              )
            : const Text(''),
      ],
    );
  }
}
