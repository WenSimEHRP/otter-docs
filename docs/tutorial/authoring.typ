#title[Authoring]

This section will cover specific authoring details when using Haita. Please refer to #link(
  "https://typst.app/docs/tutorial/",
) and #link(
  "https://typst.app/docs/reference/syntax/",
) for Typst reference.

= Cross-references

You can reference different content using the following syntax:

#figure(caption: [Reference syntax])[```typ
// This attaches a `label` to the figure
#figure(..) <my-listing>

See @my-listing for an example.
See #link(<my-listing>)[This listing]
```] <reference-listing>

In addition, you can reference different pages using ```typc label("page:/path/to/page")```. See #link(
  "https://typst.app/docs/reference/foundations/label/",
) for additional information on labels. You can write the following to create a link to a different page:

```typ
#link(label("page:/path/to/page"))[See this page for help]
```

You can even create a reference to an HTML element:

```typ
#context if target() == "html" [
  #html.section[Foo bar baz] <foobar>
]
// somewhere else in the document
#context if target() == "html" [
  #link(<foobar>)[This section] explains.
]
```

You may reference a label located in one page from the same page or from a different page.

= Contextual Output And Embedding HTML

You can write different content for different targets, for example, embedding a link to a page via `iframe` in the HTML
target. In addition, Typst provides #link("https://typst.app/docs/reference/html/typed/")[a typed interface] for HTML
elements. Custom HTML elements may be embedded using ```typc html.elem()```

```typst
#context if target() == "html" {
  // target IS HTML. Write some HTML specific stuff
  html.elem(..)
  html.iframe(..)
  // or import the entire html interface
  import html: *
  div(..)
} else {
  // target IS NOT HTML. It is instead "paged", which is for PDF, PNG and SVG.
  // Write some PDF specific stuff
  curve(..)
}
```

Please always keep HTML specific content in the ```typc context if target() == "html" {..}``` block. HTML elems will not
work when using PDF export.

#context if target() == "html" [
  You are currently looking at the HTML target. The default theme "New Hamber" is inspired by #link(
    "https://documenter.juliadocs.org/stable/",
  )[Documenter.jl]'s "Documenter" theme, which is based on sphinx's #link(
    "https://github.com/readthedocs/sphinx_rtd_theme",
  )[sphinx_rtd_theme]. // You can also take a look at the #link(<doc.pdf>)[PDF document].

  #let src = ```typ
  #let youtube-video-player = html.iframe.with(
    class: "w-full aspect-video",
    title: "YouTube video player",
    allow: {
      "accelerometer; autoplay; clipboard-write; encrypted-media;"
      " gyroscope; picture-in-picture; web-share"
    },
    referrerpolicy: "strict-origin-when-cross-origin",
    allowfullscreen: true,
  )

  #figure(
    supplement: "Video",
    caption: [Watch something ★funky★],
    youtube-video-player(
      src: "https://www.youtube-nocookie.com/embed/rl7ppuXMfC8",
    ),
  )```
  #eval(src.text, mode: "markup")

  #figure(caption: [Source code for the video player above.], src)
] else [
  You are currently looking at the PDF target.
]

= Copyable Math Blocks

Haita provides an extension to standard Typst to make math blocks copyable as Typst source. This extension only works
for math blocks, and does not work for inline math such as $a^2 + b^2 = c^2$. Typically, math blocks are written as
follows:

#let math-sample = ```typm-copy
f(x) = integral^oo_oo hat(f)(xi)e^(2pi i xi x) dif xi
```

#raw(block: true, lang: "typ", {
  "$\n  "
  math-sample.text
  "\n$"
})

This will be rendered as follows. Notice how the math block's source cannot be copied:

#math.equation(block: true, eval(math-sample.text, mode: "math"))

Instead, you can remove the ```typ $ $``` and wrap your text in the `typm-copy` code block. Haita will extract the text
from the code block, evaluate it, and render a math block with a copy button. Additionally, you can also hover on the
math block to reveal a tooltip for the Typst source:

#raw(block: true, lang: "typ", {
  "```typm-copy\n"
  math-sample.text
  "\n```"
})

#math-sample

Note that writing inside raw blocks won't give you LSP completions. In this case, you can first write the math formula
in a standard ```typc $ $```, then remove the dollar sign and wrap it in the code block. You may not reference any
outside variables when writing in this way. For example, the following snippet would not work at all since the math
block relies on a method that is not defined in Typst's standard library:

#let borked-sample = ``````typ
#let my-method(foo) = math.attach(foo, tr: foo)
// this works
$
  #my-method[8848.86]
$
// but this is borked
// ```typm-copy
// #my-method[8848.86]
// ```
``````

#borked-sample
#eval(borked-sample.text, mode: "markup")
