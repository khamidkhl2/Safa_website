import AppKit
import Foundation

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let screenshotRoot = root.appendingPathComponent("website/assets/screenshots")
let outputRoot = root.appendingPathComponent("website/assets/promo")
try FileManager.default.createDirectory(at: outputRoot, withIntermediateDirectories: true)

let canvasWidth: CGFloat = 1242
let canvasHeight: CGFloat = 2688

struct Palette {
    let base: NSColor
    let primary: NSColor
    let secondary: NSColor
    let accent: NSColor
    let ink: NSColor
}

struct PromoCard {
    let fileName: String
    let screenshotName: String
    let headline: [String]
    let kicker: String
    let phoneTop: CGFloat
    let palette: Palette
    let badge: String?
}

func color(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> NSColor {
    NSColor(calibratedRed: r / 255, green: g / 255, blue: b / 255, alpha: a)
}

let promos: [PromoCard] = [
    PromoCard(
        fileName: "01-safa-prayer-day.png",
        screenshotName: "01-today.png",
        headline: ["Safa", "every prayer, calmly kept"],
        kicker: "Prayer times, Quran, and daily progress",
        phoneTop: 690,
        palette: Palette(base: color(247, 251, 248), primary: color(78, 166, 111), secondary: color(122, 101, 210), accent: color(243, 152, 61), ink: color(23, 34, 30)),
        badge: "1 day streak"
    ),
    PromoCard(
        fileName: "02-prayer-times.png",
        screenshotName: "02-prayers.png",
        headline: ["Prayer times", "that move with your day"],
        kicker: "Calculation methods and Asr madhhab support",
        phoneTop: 620,
        palette: Palette(base: color(248, 251, 255), primary: color(76, 151, 218), secondary: color(74, 178, 138), accent: color(142, 112, 214), ink: color(25, 37, 55)),
        badge: "Sunrise included"
    ),
    PromoCard(
        fileName: "03-prayer-complete.png",
        screenshotName: "04-prayer-complete.png",
        headline: ["Celebrate", "every prayer completed"],
        kicker: "A quiet reward when you keep showing up",
        phoneTop: 640,
        palette: Palette(base: color(255, 249, 244), primary: color(149, 104, 207), secondary: color(246, 143, 56), accent: color(83, 166, 115), ink: color(42, 30, 44)),
        badge: "Prayer complete"
    ),
    PromoCard(
        fileName: "04-streak.png",
        screenshotName: "05-streak-celebration.png",
        headline: ["Build your", "daily streak"],
        kicker: "Progress that feels alive, not noisy",
        phoneTop: 665,
        palette: Palette(base: color(255, 250, 240), primary: color(243, 142, 46), secondary: color(251, 197, 89), accent: color(87, 167, 113), ink: color(47, 36, 22)),
        badge: "Streak safe"
    ),
    PromoCard(
        fileName: "05-calendar-progress.png",
        screenshotName: "03-calendar.png",
        headline: ["See every", "prayer in the calendar"],
        kicker: "Completed, missed, and pending at a glance",
        phoneTop: 610,
        palette: Palette(base: color(246, 250, 249), primary: color(76, 166, 112), secondary: color(116, 157, 218), accent: color(238, 105, 95), ink: color(22, 39, 34)),
        badge: "5 prayer dots"
    ),
    PromoCard(
        fileName: "06-quran-reader.png",
        screenshotName: "07-quran-reader.png",
        headline: ["Quran reading", "with clean focus"],
        kicker: "Arabic, translation, and transliteration",
        phoneTop: 625,
        palette: Palette(base: color(249, 248, 255), primary: color(126, 108, 216), secondary: color(79, 166, 123), accent: color(240, 187, 76), ink: color(33, 31, 56)),
        badge: "Bismillah handled"
    ),
    PromoCard(
        fileName: "07-ayah-finder.png",
        screenshotName: "06-quran.png",
        headline: ["Find the ayah", "you hear"],
        kicker: "Listen, match, and continue reading",
        phoneTop: 640,
        palette: Palette(base: color(247, 252, 250), primary: color(66, 154, 116), secondary: color(87, 144, 211), accent: color(151, 111, 213), ink: color(23, 42, 35)),
        badge: "Ayah Finder"
    ),
    PromoCard(
        fileName: "08-personalize.png",
        screenshotName: "08-settings.png",
        headline: ["Make Safa", "feel like yours"],
        kicker: "Themes, notifications, location, and timings",
        phoneTop: 630,
        palette: Palette(base: color(250, 249, 246), primary: color(84, 166, 112), secondary: color(145, 113, 211), accent: color(237, 157, 59), ink: color(31, 36, 32)),
        badge: "Six themes"
    )
]

func rectTop(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> NSRect {
    NSRect(x: x, y: canvasHeight - y - height, width: width, height: height)
}

func fillRounded(_ rect: NSRect, radius: CGFloat, color: NSColor) {
    color.setFill()
    NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius).fill()
}

func drawBlob(centerX: CGFloat, centerY: CGFloat, radius: CGFloat, color: NSColor, alpha: CGFloat) {
    let center = NSPoint(x: centerX, y: canvasHeight - centerY)
    let gradient = NSGradient(colors: [color.withAlphaComponent(alpha), color.withAlphaComponent(0)])
    gradient?.draw(fromCenter: center, radius: 0, toCenter: center, radius: radius, options: [])
}

func drawText(_ text: String, in rect: NSRect, size: CGFloat, weight: NSFont.Weight, color: NSColor, alignment: NSTextAlignment = .left) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = alignment
    paragraph.lineBreakMode = .byWordWrapping
    paragraph.lineSpacing = size * 0.08
    let font = NSFont.systemFont(ofSize: size, weight: weight)
    let attrs: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: color,
        .paragraphStyle: paragraph
    ]
    NSAttributedString(string: text, attributes: attrs).draw(in: rect)
}

func drawHeadline(_ lines: [String], palette: Palette) {
    let lineHeight: CGFloat = 112
    var y: CGFloat = 146
    for (index, line) in lines.enumerated() {
        let size: CGFloat = index == 0 && line == "Safa" ? 156 : 96
        let height = index == 0 && line == "Safa" ? 170 : lineHeight
        drawText(
            line,
            in: rectTop(82, y, canvasWidth - 164, height),
            size: size,
            weight: .heavy,
            color: palette.ink,
            alignment: .center
        )
        y += height - 8
    }
}

func drawKicker(_ text: String, palette: Palette) {
    drawText(
        text,
        in: rectTop(120, 460, canvasWidth - 240, 72),
        size: 34,
        weight: .semibold,
        color: palette.ink.withAlphaComponent(0.68),
        alignment: .center
    )
}

func drawPill(_ text: String, x: CGFloat, y: CGFloat, palette: Palette) {
    let rect = rectTop(x, y, 340, 76)
    let shadow = NSShadow()
    shadow.shadowBlurRadius = 24
    shadow.shadowOffset = NSSize(width: 0, height: -8)
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.10)
    NSGraphicsContext.current?.saveGraphicsState()
    shadow.set()
    fillRounded(rect, radius: 38, color: NSColor.white.withAlphaComponent(0.92))
    NSGraphicsContext.current?.restoreGraphicsState()
    drawText(text, in: rect.insetBy(dx: 24, dy: 19), size: 28, weight: .bold, color: palette.primary, alignment: .center)
}

func drawPhone(image: NSImage, topY: CGFloat, palette: Palette) {
    let outer = rectTop(198, topY, 846, 1828)
    let inner = outer.insetBy(dx: 31, dy: 31)

    let shadow = NSShadow()
    shadow.shadowBlurRadius = 52
    shadow.shadowOffset = NSSize(width: 0, height: -24)
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.22)

    NSGraphicsContext.current?.saveGraphicsState()
    shadow.set()
    fillRounded(outer, radius: 92, color: color(32, 35, 36))
    NSGraphicsContext.current?.restoreGraphicsState()

    NSGraphicsContext.current?.saveGraphicsState()
    fillRounded(outer, radius: 92, color: color(28, 31, 32))
    fillRounded(inner, radius: 72, color: NSColor.white)

    let path = NSBezierPath(roundedRect: inner, xRadius: 72, yRadius: 72)
    path.addClip()
    image.draw(in: inner, from: NSRect(origin: .zero, size: image.size), operation: .sourceOver, fraction: 1)
    NSGraphicsContext.current?.restoreGraphicsState()

    drawBlob(centerX: 1040, centerY: topY + 560, radius: 360, color: palette.primary, alpha: 0.16)
}

func makeBitmapCanvas() -> NSBitmapImageRep {
    guard let rep = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(canvasWidth),
        pixelsHigh: Int(canvasHeight),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ) else {
        fatalError("Could not create bitmap canvas")
    }
    rep.size = NSSize(width: canvasWidth, height: canvasHeight)
    return rep
}

func writePNG(_ rep: NSBitmapImageRep, to url: URL) throws {
    guard let png = rep.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "PromoAssetWriter", code: 1)
    }
    try png.write(to: url)
}

for promo in promos {
    guard let screenshot = NSImage(contentsOf: screenshotRoot.appendingPathComponent(promo.screenshotName)) else {
        fatalError("Missing screenshot \(promo.screenshotName)")
    }

    let canvas = makeBitmapCanvas()
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: canvas)

    promo.palette.base.setFill()
    NSRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight).fill()

    drawBlob(centerX: 230, centerY: 620, radius: 360, color: promo.palette.primary, alpha: 0.42)
    drawBlob(centerX: 1020, centerY: 360, radius: 380, color: promo.palette.secondary, alpha: 0.28)
    drawBlob(centerX: 780, centerY: 2220, radius: 440, color: promo.palette.accent, alpha: 0.22)
    drawBlob(centerX: 520, centerY: 1280, radius: 520, color: NSColor.white, alpha: 0.66)

    drawHeadline(promo.headline, palette: promo.palette)
    drawKicker(promo.kicker, palette: promo.palette)
    drawPhone(image: screenshot, topY: promo.phoneTop, palette: promo.palette)
    if let badge = promo.badge {
        drawPill(badge, x: 451, y: promo.phoneTop - 42, palette: promo.palette)
    }

    NSGraphicsContext.restoreGraphicsState()
    try writePNG(canvas, to: outputRoot.appendingPathComponent(promo.fileName))
    print("Wrote \(promo.fileName)")
}
