import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mangabuzz/screen/ui/error/error_screen.dart';
import 'package:mangabuzz/screen/ui/paginated/bloc/paginated_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/paginated/paginated_screen_placeholder.dart';
import 'package:mangabuzz/screen/widget/manga_item/manga_item.dart';
import 'package:mangabuzz/screen/widget/paginated_button.dart';
import 'package:mangabuzz/screen/widget/refresh_snackbar.dart';

class PaginatedPageArguments {
  final String name;
  final String endpoint;
  final int pageNumber;
  final bool isGenre;
  final bool isManga;
  final bool isManhwa;
  final bool isManhua;
  PaginatedPageArguments({
    @required this.name,
    @required this.endpoint,
    @required this.pageNumber,
    @required this.isGenre,
    @required this.isManga,
    @required this.isManhua,
    @required this.isManhwa,
  });
}

class PaginatedPage extends StatefulWidget {
  final String name;
  final String endpoint;
  final int pageNumber;
  final bool isGenre;
  final bool isManga;
  final bool isManhwa;
  final bool isManhua;
  PaginatedPage({
    @required this.name,
    @required this.endpoint,
    @required this.pageNumber,
    @required this.isGenre,
    @required this.isManga,
    @required this.isManhua,
    @required this.isManhwa,
  });

  @override
  _PaginatedPageState createState() => _PaginatedPageState();
}

class _PaginatedPageState extends State<PaginatedPage> {
  _getData(int pageNumber) {
    BlocProvider.of<PaginatedScreenBloc>(context).add(
        GetPaginatedScreenScreenData(
            name: widget.name,
            endpoint: widget.endpoint,
            isGenre: widget.isGenre,
            isManga: widget.isManga,
            isManhua: widget.isManhua,
            isManhwa: widget.isManhwa,
            pageNumber: pageNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<PaginatedScreenBloc, PaginatedScreenState>(
          listener: (context, state) {
            if (state is PaginatedScreenError) {
              Scaffold.of(context).showSnackBar(refreshSnackBar(() {
                _getData(widget.pageNumber);
              }));
            }
          },
          builder: (context, state) {
            if (state is PaginatedScreenLoaded) {
              return ListView(
                children: [
                  Text(
                    "Results for ${state.name}",
                    style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: state.paginatedManga.previousPage != 0
                            ? true
                            : false,
                        child: PaginatedButton(
                            text: "Prev",
                            icons: Icons.chevron_left,
                            function: () {
                              _getData(state.paginatedManga.previousPage);
                            }),
                      ),
                      Visibility(
                        visible:
                            state.paginatedManga.nextPage != 0 ? true : false,
                        child: PaginatedButton(
                            text: "Next",
                            icons: Icons.chevron_left,
                            function: () {
                              BlocProvider.of<PaginatedScreenBloc>(context)
                                  .add(_getData(state.paginatedManga.nextPage));
                            }),
                      )
                    ],
                  )
                ],
              );
            } else if (state is PaginatedScreenError) {
              return ErrorPage();
            } else {
              return buildPaginatedScreenPlaceholder();
            }
          },
        ));
  }
}
