// color: Colors.white,
//                   elevation: 5,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Row(
//                       children: <Widget>[
//                         SvgPicture.network(
//                           data['imageUrl'],
//                           width: 90,
//                           height: 90,
//                           fit: BoxFit.cover,
//                           // Vous pouvez utiliser des bibliothèques comme flutter_cache_manager pour mettre en cache les images
//                         ),
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   data['titre'],
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Text(
//                                   data['description'],
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),