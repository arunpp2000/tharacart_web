

import 'package:firebase_storage/firebase_storage.dart';



import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgets/storage.dart';
import '../../../widgets/uploadmedia.dart';


class ProductImages extends StatefulWidget {
  ProductImages({
    Key? key,
    this.productId, this.shopId, this.categoryId, this.subCategoryId, this.brandId,
  }) : super(key: key);

  final String? productId;
  final String? shopId;
  final String? categoryId;
  final String? subCategoryId;
  final String? brandId;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  String? uploadedFileUrl1;
  String? uploadedFileUrl2;
  String? videoUrl;
  var imagesItem;
List videos=[];
List images=[];


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: FlutterFlowTheme.primaryColor,
        //   automaticallyImplyLeading: true,
        //   title: Text(
        //     'Edit Product',
        //     style: FlutterFlowTheme.bodyText1.override(
        //         fontFamily: 'Poppins',
        //         color: Colors.white
        //     ),
        //   ),
        //   actions: [],
        //   centerTitle: true,
        //   elevation: 4,
        // ),
        body: SafeArea(
            child: Column(children: [
              Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection('products').doc(widget.productId).snapshots(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        // List<NewProductsRecord>
                        //     editproductNewProductsRecordList =
                        //     snapshot.data;
                        // Customize what your widget looks like with no query results.
                        if (!snapshot.data!.exists) {
                          return Text('No Data');
                          // For now, we'll just include some dummy data.

                        }


                        images = snapshot.data?.get('imageId').toList();
                        videos = snapshot.data?.get('videoUrl').toList();

















                        //

                        uploadedFileUrl1 =
                        snapshot.data?.get('imageId').length == 0
                            ? ""
                            : snapshot.data?.get('imageId')[0];
                        videoUrl=snapshot.data?.get('videoUrl').length==0
                            ? ""
                            :snapshot.data?.get('videoUrl')[0];

                        return ListView(
                            shrinkWrap: true,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final selectedMedia = await selectMedia(
                                        maxWidth: 1080.00,
                                        maxHeight: 1320.00,
                                      );
                                      if (selectedMedia != null &&
                                          validateFileFormat(
                                              selectedMedia.storagePath,
                                              context)) {
                                        showUploadMessage(
                                            context, 'Uploading file...',
                                            showLoading: true);
                                        final downloadUrl = await uploadData(
                                            selectedMedia.storagePath,
                                            selectedMedia.bytes);
                                        await FirebaseFirestore.instance
                                            .collection('products')
                                            .doc(widget
                                            .productId)
                                            .update({
                                          'imageId': FieldValue.arrayUnion(
                                              [downloadUrl]),
                                        }).then((value) {
                                          setState(() {
                                            images.add(downloadUrl);
                                          });
                                        });
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        if (downloadUrl != null) {
                                          setState(() =>
                                          uploadedFileUrl1 = downloadUrl);
                                          showUploadMessage(context, 'Success!');
                                        } else {
                                          showUploadMessage(
                                              context, 'Failed to upload media');
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      Icons.image,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    iconSize: 30,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final selectedMedia = await selectMedia(

                                          isVideo: true

                                      );
                                      if (selectedMedia != null &&
                                          validateFileFormat(

                                              selectedMedia.storagePath,
                                              context)) {
                                        showUploadMessage(
                                            context, 'Uploading Video...',
                                            showLoading: true);
                                        final downloadUrl = await uploadData(
                                            selectedMedia.storagePath,
                                            selectedMedia.bytes);
                                        await FirebaseFirestore.instance
                                            .collection('products')
                                            .doc(widget
                                            .productId)
                                            .update({
                                          'videoUrl': FieldValue.arrayUnion(
                                              [downloadUrl]),
                                        }).then((value) {
                                          setState(() {
                                            videos.add(downloadUrl);
                                          });
                                        });
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        if (downloadUrl != null) {
                                          setState(() =>
                                          videoUrl = downloadUrl);
                                          print(videoUrl);
                                          showUploadMessage(context,
                                              'Media upload Success!');
                                        } else {
                                          showUploadMessage(context,
                                              'Failed to upload media');
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      Icons.slow_motion_video_outlined,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    iconSize: 30,
                                  )
                                ],
                              ),
                              Text('Images',style:TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold
                              ),textAlign: TextAlign.center,),
                              Container(

                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: images.length,
                                  itemBuilder: (context, listViewIndex) {
                                    imagesItem = images[listViewIndex];

                                    return ListTile(
                                      title: Image.network(
                                        imagesItem,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('products')
                                              .doc(
                                              widget.productId)
                                              .update({
                                            'imageId': FieldValue.arrayRemove(
                                                [imagesItem]),
                                          }).then((value) {
                                            FirebaseStorage.instance
                                                .refFromURL(imagesItem)
                                                .delete();
                                            setState(() {
                                              images.remove(imagesItem);
                                            });
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        iconSize: 30,
                                      ),
                                    );
                                    // return CachedNetworkImage(
                                    //   imageUrl:imagesItem,
                                    //   width: 100,
                                    //   height: 100,
                                    //   fit: BoxFit.cover,
                                    // );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text('Videos',style:TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold
                                ),textAlign: TextAlign.center,),
                              ),
                              Container(

                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: videos.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final video = videos[listViewIndex];

                                    return ListTile(
                                      title:  InkWell(
                                        onTap: ()
                                        {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoViewer(
                                          //   video: video,
                                          // )));
                                        },
                                        child: Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: Image.network(
                                                    imagesItem,height: 100).image,
                                              )

                                          ),
                                          child: Center(child: Icon(Icons.play_circle_outline,size: 50,color: Colors.white,)),
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('products')
                                              .doc(
                                              widget.productId)
                                              .update({
                                            'videoUrl': FieldValue.arrayRemove(
                                                [video]),
                                          }).then((value) {
                                            FirebaseStorage.instance
                                                .refFromURL(video)
                                                .delete();
                                            setState(() {
                                              videos.remove(video);
                                            });
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        iconSize: 30,
                                      ),
                                    );
                                    // return CachedNetworkImage(
                                    //   imageUrl:imagesItem,
                                    //   width: 100,
                                    //   height: 100,
                                    //   fit: BoxFit.cover,
                                    // );
                                  },
                                ),
                              )
                            ]);
                      }))
            ])));
  }
}
