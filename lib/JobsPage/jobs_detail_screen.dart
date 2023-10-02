import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:myjobapp/utils/colors.dart';

class JobsDetailScr extends StatefulWidget {
  const JobsDetailScr({required this.data, super.key});

  final JobsClass data;

  @override
  State<JobsDetailScr> createState() => _JobsDetailScrState();
}

class _JobsDetailScrState extends State<JobsDetailScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maunen,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.share),
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              width: 330,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.data.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.data.position,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Công ty TNHH Kim Oanh / ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.location_on_outlined,
                    size: 17,
                  ),
                  Text('${widget.data.khuvuchuyen},${widget.data.khuvuctinh}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Mô tả công việc:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                      ),
                      Text(
                        '- ${widget.data.content}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Yêu cầu:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                      ),
                      Text(
                        style: TextStyle(fontSize: 16),
                        'Yêu cầu sự chính xác, tỉ mỉ và khéo léo. Các công nhân phải tuân thủ quy trình sản xuất, đảm bảo tuân thủ các quy định an toàn lao động và quy định về chất lượng. Họ cần có khả năng làm việc nhóm tốt, giao tiếp hiệu quả và thích ứng với môi trường làm việc đa dạng.',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.favorite_border_outlined,
                              size: 30,
                            ),
                            Container(
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                  child: Text(
                                'ỨNG TUYỂN',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            )
          ],
        )),
      ),
    );
  }
}
