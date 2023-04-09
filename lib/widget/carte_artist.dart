import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../localisation/language/language.dart';
import '../models/artistmodel.dart';
import '../services/api.dart';
import '../services/apiservice.dart';

class CarteArtist extends StatefulWidget {
  final ArtistModel artist;
  const CarteArtist({Key key, this.artist, String artistid}) : super(key: key);

  @override
  State<CarteArtist> createState() => _CarteArtistState();
}

class _CarteArtistState extends State<CarteArtist> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 155,
          width: 155,
          foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black38, Colors.transparent],
                  stops: [.0, .43]
              )
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: NetworkImage('http://salonat.qa/' +
                  widget.artist.image),
              fit: BoxFit.cover,
            ),
            /*boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],*/
          ),
        ),
        Positioned(
          bottom: 0,
          left: .0,
          right: .0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 1.h, vertical: 1.w),
              decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.80),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
                /*boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 2.5,
                    spreadRadius: 2.5,
                  ),
                ],*/
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    widget.artist == null
                        ? const Center()
                        : Languages.of(context)
                        .labelSelectLanguage ==
                        'English'
                        ? widget.artist.name
                        : widget.artist.nameAr,
                    style: white13SemiBoldTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                  /*if (widget.artist.open_close.toLowerCase() == 'closed')
                    Text(Languages.of(context).closed, style: white10SFProMediom,)*/
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: _favButton(
              done: favorite ? true : false),
        )
      ],
    );
  }
  _updateFavorite() {
    if (API.USER == null) {
      return;
    }
    WebService()
        .updateFav(
      id: widget.artist.id.toString(),
    )
        .then((value) {
      setState(() {
        favorite = value;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(favorite ? Languages.of(context).add : Languages.of(context).remove),
          behavior: SnackBarBehavior.floating,
        ));
      });
    });
  }

  Widget _favButton({bool done = false}) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: _updateFavorite,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(done ? Icons.favorite : Icons.favorite_border,
            color: done ? Colors.red.shade600 : Colors.white,
          )),
    );
  }
}
