// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog_explorer/blog/bloc/blog_bloc.dart';
import 'package:blog_explorer/blog/bloc/blog_event.dart';
import 'package:blog_explorer/blog/bloc/blog_state.dart';
import 'package:blog_explorer/ui/detailscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetched());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          bottom: TabBar(labelColor: Colors.white, tabs: [
            Tab(
              text: "All",
            ),
            Tab(text: "Business"),
            Tab(text: "Tutorial")
          ]),
          backgroundColor: const Color.fromARGB(221, 51, 50, 50),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          title: const Text(
            "Blogs And Articles",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.blue,
            )
          ],
        ),
        body: TabBarView(
          children: [
            _buildBlogList(context),
            // _buildBlogList(context),
            // _buildBlogList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogList(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state.blogStatus == BlogStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.blogStatus == BlogStatus.failure) {
          return Center(
            child: Text(
              'Failed to fetch blogs. Please try again later.',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (state.blogStatus == BlogStatus.success) {
          if (state.blogList.isEmpty) {
            return const Center(
              child: Text(
                "No Blogs Available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.blogList.length,
            itemBuilder: (context, index) {
              final blog = state.blogList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogDetailScreen(
                        title: blog.title ?? 'No Title',
                        description: blog.title ?? 'No Description',
                        imageUrl: blog.imageUrl ?? '',
                      ),
                    ),
                  );
                },
                child: Card(
                  color: const Color.fromARGB(112, 89, 88, 88),
                  elevation: 4.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: blog.imageUrl ?? '',
                          placeholder: (context, url) => const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            height: 200,
                            child: Icon(Icons.broken_image_outlined,
                                size: 60, color: Colors.white),
                          ),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          blog.title ?? 'No Title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              "No Data To Show",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}
