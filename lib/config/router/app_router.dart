import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  
  
  initialLocation: HomeScreen.name,
  routes: [

    GoRoute(
      path: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    
  ],

);
