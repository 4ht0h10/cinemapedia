import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return Container(
        alignment: Alignment.topCenter,
        color: Colors.orange,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.movie_creation_outlined, color: colors.primary),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Cinemapedia', style: titleStyle,),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: (){},
                    )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
