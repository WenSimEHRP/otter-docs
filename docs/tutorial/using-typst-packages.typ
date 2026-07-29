#import "../mod.typ": *
#title[Using Other Typst Packages]

You can add any Typst pacakges into your document using the package import syntax:

```typ
#import "@preview/my-package:version": foo, bar
```

Many packages are available in the #link("https://typst.app/universe/")[Typst Universe]. Go check them out!

= Package Support

Packages have varying levels of HTML support. If you generally use Haita for the PDF export, this won't be a major
problem. If you use Haita primarily for HTML export, check if your package supports HTML.

Additionally, if you draw diagrams with Typst, it is a good idea to wrap your diagram in ```typc html.frame()```. In
HTML export, it turns the content into an SVG illustration that gets embedded into your HTML page; in PDF export, this
emits regular PDF content.

#figure(caption: [A #link("https://cetz-package.github.io/")[CeTZ] illustration], cetz-illustration)

```typ
#let cetz-illustration = { /* Draw your content here */ }
#figure(caption: [Your Caption], html.frame(cetz-illustration))
```

= Integration with Tidy

#link("https://typst.app/universe/package/tidy/")[Tidy] is a Typst documentation tool. Haita's default theme, _New
Hamber_, provides built-in integration for rendering Tidy modules.
