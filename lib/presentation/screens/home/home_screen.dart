import 'dart:async';

import 'package:appscrip_pract/blocs/home/user_bloc.dart';
import 'package:appscrip_pract/config/app_colors.dart';
import 'package:appscrip_pract/config/app_text_styles.dart';
import 'package:appscrip_pract/presentation/widgets/search_text_field.dart';
import 'package:appscrip_pract/presentation/widgets/user_shimmer_widget.dart';
import 'package:flutter/cupertino%20(2).dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../blocs/home/user_event.dart';
import '../../../blocs/home/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  bool _isConnectedToInternet = false;
  StreamSubscription? _internetConnectionSubscription;

  @override
  void initState() {
    super.initState();
    _internetConnectionSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            _isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            _isConnectedToInternet = false;
          });
          break;
        default:
          setState(() {
            _isConnectedToInternet = false;
          });
      }
    });
    context.read<UserBloc>().add(FetchUsers());
  }

  Future<void> _refreshData() async {
    context.read<UserBloc>().add(FetchUsers());
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _internetConnectionSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'User List',
          style: AppTextStyles(context)
              .display20W700
              .copyWith(color: AppColors.appWhiteColor),
        ),
        centerTitle: true,
      ),
      body: _isConnectedToInternet == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_statusbar_connected_no_internet_4,
                    size: 50,
                  ),
                  Text(
                    'No Internet Connection',
                    style: AppTextStyles(context)
                        .display20W700
                        .copyWith(overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  SearchTextField(onChanged: _onSearchChanged),
                  SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return UserShimmerListView();
                        } else if (state is UserLoaded) {
                          final filteredUsers = state.users
                              .where((user) => (user.name ?? '')
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                              .toList();
                          return RefreshIndicator(
                            onRefresh: _refreshData,
                            child: ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                final user = filteredUsers[index];
                                return ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user.name ?? '',
                                        style: AppTextStyles(context)
                                            .display20W700
                                            .copyWith(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        user.address?.city ?? '',
                                        style: AppTextStyles(context)
                                            .display11W500
                                            .copyWith(
                                                color: Colors.grey,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(user.email ?? ''),
                                );
                              },
                            ),
                          );
                        } else if (state is UserError) {
                          return Center(child: Text('Error: ${state.message}'));
                        }
                        return Center(child: Text('No users available'));
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
