import 'package:flutter/material.dart';
import 'package:isntagram/utils/colors.dart';

// responsible for holding posts in the feed screen
class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1522149537340-1ec572853077?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fG1lZGlhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  // post menu button dialog action
                  onPressed: () {
                    // menu dialog
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shrinkWrap: true,
                          children: [
                            // dialog menu items
                            'Delete',
                          ]
                              .map(
                                (e) => InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    child: Text(e),
                                  ),
                                ),
                                // cast the mapped items as a list
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          // IMAGE SECTION
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              'https://images.unsplash.com/photo-1522149537340-1ec572853077?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fG1lZGlhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.cover,
            ),
          ),

          // LIKE COMMENT SECTION
          Row(
            children: [
              // like icon
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              // comment icon
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              // send icon
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              // bookmark icon
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_outline),
                  ),
                ),
              ),
            ],
          ),
          // DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '1,231 likes',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8),
                    // rich text allows us to have many texts
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(color: primaryColor),
                          children: [
                            TextSpan(
                              text: 'username',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  '  Hey this is the description fot demo purposes. Hey this is the description fot demo purposes',
                            ),
                          ]),
                    ),
                  ),
                  // number of comments
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'View all 200 comments',
                        style: TextStyle(fontSize: 16, color: secondaryColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '12/03/2023',
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
