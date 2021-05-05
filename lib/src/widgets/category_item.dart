import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String titile;
  final Color color;
  final String ids;
  CategoryItem({this.color, this.titile, this.ids});

  void selectCategory(BuildContext context, String id) {
    switch (id) {
      case 'c1':
        {
          Navigator.of(context).pushNamed('/news');
        }
        break;
      case 'c2':
        {
          Navigator.of(context).pushNamed('/location');
        }
        break;
      case 'c3':
        {
          print('c3');
          // Navigator.of(context).pushNamed('/location');
        }
        break;
      case 'c4':
        {
          print('c4');
          // Navigator.of(context).pushNamed('/location');
        }
        break;
      default:
        {
          print('nothing');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context, ids),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          titile,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
