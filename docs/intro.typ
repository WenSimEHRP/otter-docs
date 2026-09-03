#import "mod.typ": *
#title[Introduction]

Welcome to the documentation for Haita #version (hǎi tǎ, Mandarin Pinyin, lit. Sea Otter).

#context if target() == "html" {
  info[PDF Ready!][
    The documentation is also available #link("./doc.pdf")[as a PDF].
  ]
} else {
  info[Web Ready!][
    The documentation is also available #link("./index.html")[as HTML].
  ]
}

#import "../readme.typ": license-fragment-1, readme-fragment-1

#import "@preview/merman:0.1.0": mermaid
#let to-raw-html(content) = {
  for c in content {
    if type(c) == dictionary and "tag" in c {
      let attrs = c.attrs
      html.elem(c.tag, attrs: attrs, to-raw-html(c.children))
    } else {
      c
    }
  }
}
#figure(caption: [How Haita Works], {
  // TODO: find a way to make this output better SVG
  //       font; colour; better theming.
  // ref to merman:
  //   https://typst.app/universe/package/merman/
  //   https://github.com/Latias94/merman
  show image: it => context if target() == "html" {
    let a = xml(it.source)
    to-raw-html(a)
    html.style(
      ```css
        text {
            font-family: "Lato" !important;
        }
      ```.text,
    )
  } else { it }
  mermaid(
    background: "transparent",
    host-theme: (
      fontFamily: "Lato",
      roles: (
        surface: "#fe84",
        text: "currentColor",
        border: "#a988",
        line: "currentColor",
      ),
    ),
    ```mermaid
    flowchart LR
    T[Typst Content]
    Mermaid -- merman --> T
    Markdown -- cmarker --> T
    LaTeX -- mitex --> T
    D[...] --> T
    T -- Haita --> HTML
    T -- Haita --> PDF
    ```.text,
  )
})

#readme-fragment-1

#figure(
  caption: [A math formula example (#link(
      "https://tex.stackexchange.com/questions/176443/large-equation-goes-out-of-margin-want-to-centre-it",
    )[source]). Hover on the equation to reveal the copy button!],
  ```typm-copy
  italic(W) = (Psi'^2 a b)/(2 mu_0) [
    mu^2 + sum_(m,n) ((a^2_(m n))/4 ((m^2 n^2)/a^2 + (n^2 pi^2)/b^2 + mu^2) + (8 a_(m n) mu^2)/(pi^2 m n) )
  ]
  ```,
)

#figure(
  caption: [See how it renders with Typst + MathML (#link(
      "https://katex.org/",
    )[source])],
  ```typm-copy
  f(x) = integral^oo_oo hat(f)(xi)e^(2pi i xi x) dif xi
  ```,
)

The default theme, _New Hamber_, also supports dark mode.

You can make a new project in Typst using Haita, set it to #link("https://github.com/typst/typst/pull/7964")[bundle
  export], and Haita would generate a site for you. You don't need to worry about setting up the toolchain – Typst is
the only tool required.

= An Unfinished Project

#warning[It's not ready yet!][
  Haita is a decent choice for organizing long, comprehensive documentation. But just like Typst, Haita is an unfinished
  project, and is (currently) not a serious tool.
]

Haita is still missing some features, specifically:

- Internationalization support
- Built-in search functions

#tip[Pagefind Integration][
  You can integrate Pagefind manually. See #link(<pagefind-integration>)[this page] for details.
]

However, if you want pure Typst documentation, ease of use, and/or MathML formulae, you might want to give it a try. If
you want stability and extremely easy syntax, then maybe you should consider mdBook. If you have any issues, please feel
free to #link("https://github.com/wensimehrp/haita/issues")[open a ticket on GitHub]. If you would like to contribute,
please #link("https://github.com/wensimehrp/haita/pulls")[open a pull request].

= Licensing

#license-fragment-1

#info[Tracking][
  This site uses #link("https://umami.is/")[Umami] to track visitor status. It stores no cookies and does not collect
  personal data. All data collected are anonymous, and you can disable tracking for this site following #link(
    "https://docs.umami.is/docs/exclude-my-own-visits",
  )[this guide].
]
