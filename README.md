
# stamp_image

Stamp Image is a library to create a watermark using any widget, you can customize the position
of the watermark and set multiple watermark in one images

[![GitHub issues](https://img.shields.io/github/issues/yusriltakeuchi/stamp_image.svg)](https://github.com/yusriltakeuchi/stamp_image/issues/)&nbsp;  [![GitHub pull-requests](https://img.shields.io/github/issues-pr/yusriltakeuchi/stamp_image.svg)](https://GitHub.com/yusriltakeuchi/stamp_image/pull/)&nbsp; [![Example](https://img.shields.io/badge/Example-Ex-success)](https://pub.dev/packages/stamp_image/example)&nbsp; [![Star](https://img.shields.io/github/stars/yusriltakeuchi/stamp_image?style=social)](https://github.com/yusriltakeuchi/stamp_image/star)&nbsp; [![Get the library](https://img.shields.io/badge/Get%20library-pub-blue)](https://pub.dev/packages/stamp_image)

<p>
<img src="https://i.ibb.co/tYTyHgz/Screenshot-2021-03-22-13-04-12-505-com-example-example.jpg" height="480px">
<img src="https://i.ibb.co/ZS7LpsT/Screenshot-2021-03-22-13-07-09-189-com-example-example.jpg" height="480px">
</p>

# Exampe use case
1. Set Address Name to Picture From Camera / Gallery
2. Set Logo Company to Product Image
3. Set temperature to Picture

# Example Code:
```dart
void generate() {
  StampImage.create(
    context: context, 
    image: imageFile, 
    child: [
      Positioned(
        bottom: 0,
        right: 0,
        child: _watermarkItem(),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: _logoFlutter(),
      )
    ],
    onSuccess: (file) {
      resultStamp(file);
    }
  );
}
```

# About Me
Visit my website : [leeyurani.com](https://leeyurani.com)

Follow my Github : [![GitHub followers](https://img.shields.io/github/followers/yusriltakeuchi.svg?style=social&label=Follow&maxAge=2592000)](https://github.com/yusriltakeuchi?tab=followers)
