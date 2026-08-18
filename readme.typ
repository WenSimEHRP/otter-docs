// For generating README.md
// DO NOT EDIT THE MARKDOWN FILE! Edit this template instead
#image("demo.avif", alt: "Haita with the default theme New Hamber")

#let readme-fragment-1 = [
  Writing documentation is a lame task. It is even more boring and frustrating when you have to setup toolchains and
  environments and debug for hours to make sure that they build correctly, only to find that the current tools cannot
  plot your diagrams, or the PDF generation is missing fonts and takes hours to build. So here's Haita. *A simple tool
  that has a single requirement: #link("https://github.com/typst/typst")[Typst]*. Here are some features:

  - Pure Typst workflow
  - Features inherited from Typst:
    - Simple yet expressive Typst syntax helping you focussing on your content
    - Native syntax highlighting
    - Native MathML output
    - Fast compliation
    - Native support for `watch` and `serve`
    - PDF and HTML generation from the same source #footnote[
        PDF generation only works when using `--foramt pdf` and does not work with `--format bundle`. See #link(
          "https://github.com/typst/typst/issues/8309",
        ) for details.
      ]
    - HTML minification.
  - Minimal client side JS by default (for copying code). No JS required for math blocks. Site fully usable and
    navigatable without JS.
  - Good SEO, including generating preview images for links.
  - Semantic output, and
  - Minimal setup
]

#let installation-fragment-1 = [
  Installing Haita’s dependencies is incredibly simple! You only need the Typst compiler. Typst will automatically fetch
  the required packages when compiling the documents.
]

#let license-fragment-1 = [
  The source and the documentation are available under #link("https://www.apache.org/licenses/LICENSE-2.0")[Apache
    License v2.0].
]

= Haita

Checkout the #link("https://wensimehrp.github.io/haita/installation.html")[online user guide] to start using Haita! The
guide also uses Haita.

#readme-fragment-1

== Installation

#installation-fragment-1

== Example

#raw(lang: "typ", block: true, read("template/main.typ"))

== Licensing

#license-fragment-1
