#import "@preview/frame-it:2.0.0": *
#let version = toml("../typst.toml").package.version
#let (warning, tip, info) = frames(
  warning: ("Warning", red.darken(20%)),
  tip: ("Tip", green.darken(20%)),
  info: ("Info", blue)
)
