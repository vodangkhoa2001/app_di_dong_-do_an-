// ignore_for_file: sized_box_for_whitespace, no_logic_in_create_state, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:async';

import 'package:ban_laptop/main.dart';
import 'package:ban_laptop/models/cart.dart';
import 'package:ban_laptop/models/product/product.dart';
import 'package:ban_laptop/routes/product/payment.dart';
import 'package:ban_laptop/screens/account.dart';
import 'package:ban_laptop/screens/loading.dart';
import 'package:ban_laptop/screens/shopping.dart';
import 'package:ban_laptop/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'package:ban_laptop/screens/shopping.dart';

class Details extends StatefulWidget {
  Details({Key? key, required this.product, required this.banner})
      : super(key: key);
  Product product;
  String banner;

  @override
  _DetailsState createState() => _DetailsState(product, banner);
}

class _DetailsState extends State<Details> {
  Product product;
  String banner;
  _DetailsState(this.product, this.banner);
  final f = new NumberFormat("#,##0", "vi_VN");
  final storage = FlutterSecureStorage();
  String? id;
  bool check = false;
  void loading() {
    setState(() {
      check = true;
    });
    Future.delayed(Duration(seconds: 1), stop);
  }

  void loading2() {
    setState(() {
      check = true;
    });
    Future.delayed(Duration(seconds: 1), toChat);
  }

  toChat() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(tab: 2)),
        (route) => false);
  }

  void stop() {
    setState(() {
      check = false;
    });
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: 300,
              height: 80,
              child: Column(
                children: [
                  Text('Đã thêm thành công'),
                  SizedBox(height: 10),
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green[400],
                    size: 40,
                  )
                ],
              ),
            ),
            actions: [
              Center(
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết sản phẩm'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 350,
                        height: 300,
                        child: AspectRatio(
                          aspectRatio: 1.02,
                          child: Image.network('${product.hinhAnh}'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${product.tenSanPham}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 700,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1, //Bán kính lan rộng
                          blurRadius: 4, //Làm mờ bán kính
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: banner == "Mới" || banner == ""
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                f.format(product.giaBan) + ' VND',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  decorationColor: Colors.white,
                                  color: Colors.white,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                f.format(product.giaBan) + ' VND',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.white,
                                  color: Colors.white,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                              Text(
                                f.format(product.giaNhap) + ' VND',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    height: 50,
                    width: 700,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1, //Bán kính lan rộng
                          blurRadius: 4, //Làm mờ bán kính
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Mô tả sản phẩm",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      // 'HIỆU NĂNG ẤN TƯỢNG TỪ CHIP M1'
                      // '\n\nChip M1 được Apple thiết kế dành riêng cho MacBook mang đến hiệu năng vượt trội. Thực hiện tốt các tác vụ văn phòng trên các phần mềm như Word, Excel, Powerpoint,... Thiết kế đồ hoạ cũng chuyên nghiệp không kém, cho phép bạn chỉnh sửa hình ảnh với dung lượng lớn, kết xuất 2D mượt mà trên các phần mềm Photoshop, AI, Figma,...'
                      // '\n\n Card đồ họa GPU 7 nhân đem lại hiệu suất cao đáng kinh ngạc, đồ họa cao hơn gấp 5 lần, thảo sức sáng tạo nội dung, kết xuất 3D ổn định, render video, phát trực tiếp với chất lượng cao với chất ảnh sắc nét cùng độ phân giải lên đến 4K.'
                      // '\n\nBộ nhớ RAM 16 GB cho phép bạn sử dụng đa nhiệm, bạn có thể thao tác nhiều ứng dụng cùng một lúc thoải mái với những tác vụ như lướt web, soạn thảo văn bản, xem video hay thiết kế hình ảnh bằng Photoshop, Adobe IIIustrator,...'
                      // '\n\nỔ cứng SSD 256 GB giúp máy có tốc độ đọc ghi nhanh chóng đồng thời mang lại không gian bộ nhớ đủ lớn phục vụ cho nhu cầu lưu trữ của bạn như tài liệu trong học tập, dữ liệu trong công việc, các bộ phim hoặc bản nhạc trong giải trí. Đồng thời, tiết kiệm được thời gian khởi động máy hoặc mở các ứng dụng nặng, cải thiện được thời gian mở nhanh chóng hơn.'
                      // '\n\nFaceTime Camera cho hình ảnh rõ nét kết hợp với 3 microphone thuận tiện cho nhu cầu họp hoặc học online hay hội đàm trực tuyến, giải quyết hiệu quả công việc từ xa qua các phần mền Zoom, Google Meet,...'
                      // '\n\nHệ thống loa kép cho âm thanh to rõ, sống động để bạn có trải nghiệm nghe nhạc, xem phim và gọi điện trực tuyến thoải mái với âm thanh chất lượng cao. Tạo cho bạn cảm giác đắm chìm trong những chương trình giải trí hấp dẫn.',
                      '${product.moTa}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    height: 50,
                    width: 700,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1, //Bán kính lan rộng
                          blurRadius: 4, //Làm mờ bán kính
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Thông tin chi tiết",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 600,
                    child: DataTable(
                      border: const TableBorder(
                        horizontalInside: BorderSide(color: Colors.blue),
                        //right: BorderSide(color: Colors.blue.shade400),
                        //bottom: BorderSide(color: Colors.blue.shade400),
                        //top: BorderSide(color: Colors.blue.shade400),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[90],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Tên',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Thông số',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Màu')),
                          DataCell(Text('${product.tenMau}')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('CPU')),
                          DataCell(Text('${product.tenCPU}')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('RAM')),
                          DataCell(Text('${product.tenRam}')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Ổ Cứng')),
                          DataCell(Text('${product.tenOCung}')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Màn hình')),
                          DataCell(Text('${product.tenManHinh}')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Card đồ họa')),
                          DataCell(Text('${product.tenCardManHinh}')),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    height: 50,
                    //width: 234,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1, //Bán kính lan rộng
                          blurRadius: 4, //Làm mờ bán kính
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Đánh giá sản phẩm",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 28.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 28.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 28.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 28.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 28.0,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade300)),
                child: ListView(
                  children: [
                    Card(
                      color: Colors.grey[200],
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/avatars/avatar_user_1.jpg'),
                        ),
                        title: Text(
                          'Trần Hiếu Khoa\t 5 phút',
                          style: TextStyle(fontSize: 12),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text('Sản phẩm sử dụng tốt'),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.reply),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Card(
                            color: Colors.grey[200],
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Text(
                                'Admin\t 2 phút',
                                style: TextStyle(fontSize: 12),
                              ),
                              subtitle: Text('Cảm ơn bạn đã đánh giá sản phẩm'),
                              trailing: Icon(Icons.reply),
                            ))),
                  ],
                )),
            SizedBox(height: 100)
          ],
        ),
        bottomSheet: Table(
          border: const TableBorder(top: BorderSide(color: Colors.blue)),
          children: [
            TableRow(children: [
              FlatButton(
                  onPressed: () {
                    loading2();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Icon(
                        Icons.chat,
                        color: Colors.grey,
                      ))),
              FlatButton(
                  onPressed: () async {
                    id = await storage.read(key: 'id');
                    final snackBar = SnackBar(
                      content: Text('Thêm sản phẩm thành công'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    String data =
                        await CallApi.addCart(id!, product.id.toString(), 1);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.blue,
                      ))),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              width: 300,
                              height: 60,
                              child: Center(
                                child: Text('Bạn có chắc mua ngay ?'),
                              ),
                            ),
                            actions: [
                              Center(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FlatButton(
                                    onPressed: () {
                                      Cart cart = new Cart(sanPham:product, soLuong: 1);
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Payment(lstCart: [],
                                                    cartItem: cart,
                                                  )));
                                    },
                                    child: Text('OK'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Đóng'),
                                  ),
                                ],
                              ))
                            ],
                          );
                        });
                  },
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        'Mua ngay',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ))),
            ]),
          ],
        ),
      ),
      if (check) Loading2() else Padding(padding: EdgeInsets.zero)
    ]);
  }
}

Widget Loading2() {
  return Center(
    child: Container(
      width: 300,
      height: 140,
      alignment: AlignmentDirectional.center,
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: CircularProgressIndicator(),
    ),
  );
}
