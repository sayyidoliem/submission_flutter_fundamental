import 'package:submission_flutter_fundamental/import.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeBloc>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc myHomeBloc = context.read<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("RestoLine"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: myHomeBloc,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeSuccess) {
            final homeData = state.restaurant;
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth <= 600) {
                  return ListTileHomeRestaurant(homeData: homeData);
                }
                if (constraints.maxWidth <= 850) {
                  return GridViewHomeRestaurant(
                    homeData: homeData,
                    crossAxisCount: 2,
                  );
                }
                if (constraints.maxWidth <= 1165) {
                  return GridViewHomeRestaurant(
                    homeData: homeData,
                    crossAxisCount: 3,
                  );
                } else {
                  return GridViewHomeRestaurant(
                    homeData: homeData,
                    crossAxisCount: 4,
                  );
                }
              },
            );
          } else {
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().getData();
                  },
                  child: const Icon(Icons.abc)),
            );
          }
        },
      ),
    );
  }
}
