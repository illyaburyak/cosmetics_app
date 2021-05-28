import 'package:flutter/material.dart';
import '../providers/commentsProvider.dart';
import 'package:provider/provider.dart';

class ItemCommentView extends StatefulWidget {
  @override
  _ItemCommentViewState createState() => _ItemCommentViewState();
}

class _ItemCommentViewState extends State<ItemCommentView> {
  @override
  Widget build(BuildContext context) {
    final individComment = Provider.of<Comment>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              ExpansionTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.network(
                        'https://cdn.psychologytoday.com/sites/default/files/styles/article-inline-half/public/blogs/1104/2012/11/111493-109302.jpg?itok=YQUrufRF'),
                  ),
                ),
                childrenPadding: EdgeInsets.all(16),
                textColor: Colors.black,
                title: Text('This is my Name'),
                subtitle: Row(
                  children: [
                    Text('See Comment'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      Provider.of<CommentsProvider>(context, listen: false)
                          .deleteComment(individComment.id!);
                    });
                  },
                ),
                children: [
                  Text(
                    'My rate is ${individComment.rate!.toString()}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 2,
                  ),
                  Text(
                    individComment.descr!,
                    style: TextStyle(fontSize: 18, height: 1.4),
                  ),
                  if (individComment.img != null)
                    Image.network(
                      individComment.img!,
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                      height: 150,
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
