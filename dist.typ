#!/usr/bin/env -S sh -c 'typst c --features bundle,html --format bundle $0 $*'
#import "lib.typ": *
#import "@preview/cmarker:0.1.10"

#let offset-chapter(path, ..args) = chapter(
  path,
  content: include "docs/" + path + ".typ",
  ..args,
)

#book(
  debug: true,
  title: "Haita Docs Documentation",
  base-url: "https://wensimehrp.github.io/haita",
  html-renderer: new-hamber.html-renderer.with(
    pagefind-enabled: true,
    summary-image-renderer: new-hamber.summary-image-renderer.with(
      "Haita",
      bottom-content: [
        Haita is a pure Typst documentation framework
      ],
    ),
    // tracking script
    extra-head-content: {
      html.elem("script", attrs: (
        defer: "",
        src: "https://umami-theta-pink.vercel.app/script.js",
        data-website-id: "bbe83d2b-314a-4023-87e7-765f49b46a0c",
      ))
    },
  ),
  tree: (
    chapter("index", content: include "docs/intro.typ"),
    [= User Guide],
    offset-chapter("installation"),
    offset-chapter("tutorial", children: (
      offset-chapter("tutorial/authoring"),
      offset-chapter("tutorial/using-typst-packages"),
      offset-chapter("tutorial/integration"),
      offset-chapter("tutorial/custom-renderer"),
      offset-chapter("tutorial/continuous-integration"),
    )),
    divider(),
    offset-chapter("references"),
    offset-chapter("demo", children: (
      offset-chapter("demo-code"),
    )),
    chapter(
      "changelog",
      content: title[Changelog]
        + cmarker.render(
          label-prefix: "changelog-",
          read("CHANGELOG.md"),
        ),
    ),
  ),
)
