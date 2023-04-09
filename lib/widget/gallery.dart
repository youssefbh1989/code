import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:salonat/models/salonmodels.dart';

class Gallery_Widget extends StatelessWidget {
  final List<SalonModel> gallery;
  const Gallery_Widget({Key key, this.gallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      staggeredTileBuilder: (index) => index % 7 == 0
          ? StaggeredTile.count(2, 2)
          : StaggeredTile.count(1, 1),
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: gallery.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage('https://salonat.qa/' +
                  gallery[index].gallery[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
