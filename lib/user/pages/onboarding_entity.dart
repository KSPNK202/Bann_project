
class OnBoardingEntity {
  final String? image;
  final String? title;
  final String? description;

  OnBoardingEntity({this.image, this.title, this.description});

  static List<OnBoardingEntity> onBoardingData = [
    OnBoardingEntity(
        image: "onBoard_1.png",
        title: "เลือกซื้ออาหาร & เครื่องดื่ม\nได้ที่บ้านหลังเติบ",
        description: "มีเมนูให้เลือกมากมายไม่ว่าจะเป็น\nชุดโปรโมชั่น ของทานเล่น\nอาหารจานหลัก และเครื่องดื่ม"
    ),
    OnBoardingEntity(
        image: "onBoard_2.png",
        title: "สามารถเลือกสั่งรับประทานที่ร้าน\nหรือเลือกสั่งกลับได้",
        description: "มีระบบจองโต๊ะเมื่อสั่งสินค้าและรับประทานที่ร้าน\nหรือจะนำกลับบ้านไปรับประทานกับครอบครัวก็เลือกได้"
    ),
    OnBoardingEntity(
        image: "onBoard_3.png",
        title: "ระบบเติมเงินเพื่อชำระ\nและระบบจัดการข้อมูล",
        description: "ปลอดภัยไร้กังวล\nและยังได้อิ่มท้องสบายใจ!!"
    ),
  ];
}