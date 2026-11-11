# حزم مكتبة التصميم التعليمي

حزم معايير التصميم التعليمي، جاهزة للتنزيل بأمر واحد. كل حزمة تعمل وحدها بعد التنزيل: المعيار، والتعليمات، والمراجع، والأدوات.

| المعيار | المعرّف | الحجم |
|---|---|---|
| معيار الدورة المتجانسة | `simple-course` | 33.6 ميغابايت |
| معيار الدورة التفاعلية المتنوعة | `interactive-course` | 14.0 ميغابايت |
| معيار إنتاج الفيديو التعليمي | `video-production` | 35.5 ميغابايت |

## التثبيت

افتح الترمنال داخل مجلد مشروعك، ثم انسخ الأمر. ينزّل الأمر الحزمة ويفكّها في مجلد باسم المعيار.

**ويندوز (PowerShell)**

```powershell
irm https://raw.githubusercontent.com/learning-design-hub/ldh-packages/main/install/simple-course.ps1 | iex
```

**ماك أو لينكس (Terminal)**

```bash
curl -fsSL https://raw.githubusercontent.com/learning-design-hub/ldh-packages/main/install/simple-course.sh | sh
```

بدّل `simple-course` بمعرّف المعيار الذي تريده.

### بدون سكربت

إن منعت جهتك تشغيل السكربتات، نزّل الحزمة وفكّها يدويًا:

```powershell
iwr https://github.com/learning-design-hub/ldh-packages/releases/latest/download/simple-course.zip -OutFile simple-course.zip; Expand-Archive simple-course.zip
```

أو من صفحة [الإصدارات](https://github.com/learning-design-hub/ldh-packages/releases/latest) مباشرة.

### إصدار محدد

```powershell
$env:LDH_VERSION = 'v1.1.0'; irm https://raw.githubusercontent.com/learning-design-hub/ldh-packages/main/install/simple-course.ps1 | iex
```

## بعد التثبيت

ابدأ بالملف `00-ابدأ-هنا.md` داخل مجلد الحزمة، ثم `PACKAGE_README.md`.

## للمشرفين: نشر إصدار جديد

1. ضع الحزم في `release-assets/` بأسماء المعرّفات (`simple-course.zip` …). هذا المجلد لا يُرفع إلى المستودع.
2. حدّث `version` وأحجام الحزم و`sha256` في `packages.json`.
3. أنشئ إصدارًا جديدًا وارفع الحزم ملفاتٍ له:

```bash
gh release create v1.2.0 release-assets/*.zip --title "v1.2.0" --notes "ما الذي تغيّر"
```

الرابط `releases/latest/download/...` ينتقل تلقائيًا لآخر إصدار، فلا تتغيّر أوامر التثبيت.
