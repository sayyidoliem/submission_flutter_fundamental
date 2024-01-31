import 'package:submission_flutter_fundamental/import.dart';

class DetailPage extends StatefulWidget {
  final int index;

  const DetailPage({super.key, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context.read<DetailBloc>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.index;

    DetailBloc myDetailBloc = context.read<DetailBloc>();
    return BlocBuilder<DetailBloc, DetailState>(
      bloc: myDetailBloc,
      builder: (context, state) {
        if (state is DetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DetailSuccess) {
          final detailData = state.restaurant[index];
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 500,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        detailData.pictureId,
                        width: MediaQuery.of(context).size.longestSide,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        detailData.name.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          backgroundColor: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      titlePadding: const EdgeInsets.all(16),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.place),
                        const Padding(padding: EdgeInsets.only(left: 8.0)),
                        Text(detailData.city)
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star),
                        const Padding(padding: EdgeInsets.only(left: 8.0)),
                        Text(detailData.rating.toString())
                      ],
                    ),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Deskripsi",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        Text(
                          detailData.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Divider(),
                        const Text("Daftar Menu",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Makanan :",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 5,
                          children: detailData.menus.foods!
                              .map(
                                (food) => Chip(
                                  label: Text(food.name),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Minuman :",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 5,
                          children: detailData.menus.drinks!
                              .map(
                                (drink) => Chip(
                                  label: Text(drink.name),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is DetailError) {
          print(state);
          return const ErrorPage();
        } else {
          return Center(
            child: ElevatedButton(
                onPressed: () {
                  context.read<DetailBloc>().getData();
                },
                child: const Text("reload")),
          );
        }
      },
    );
  }
}
