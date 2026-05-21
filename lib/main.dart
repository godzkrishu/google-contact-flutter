/// main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_contact/routes/app_router.dart';
import 'firebase_options.dart';
import 'init_dependencies.dart';
import 'features/contacts/presentation/bloc/contact_bloc.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// FIREBASE
  await Firebase.initializeApp(
    options:
    DefaultFirebaseOptions
        .currentPlatform,
  );

  /// DEPENDENCY INJECTION
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) =>
              serviceLocator<ContactsBloc>(),
        ),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Contacts App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
          ColorScheme.fromSeed(
            seedColor:
            Colors.deepPurple,
          ),
        ),

        routerConfig: appRouter,
      ),
    );
  }
}