#title[Integrating Tools and Assets]

Haita doesn't have macros since Typst doesn't have macros. It is hard to achieve mdBook style preprocessors. However,
there are a few ways you can integrate foreign tools and assets in your documentation.

There are a couple of scenarios where you might want to integrate other tools and assets, for example, showing a copy of
a file in the docs, displaying an interactive editor, or demonstrating the result of a program. Most of them are doable
with Typst's capabilities, and some require specific workarounds.

= Reading and Processing Files

Typst provides native syntax for reading files. Specifically, there are these functions and keywords:

#let tr(..args) = args.pos()
#table(
  columns: 2,
  ..tr(
    link("https://typst.app/docs/reference/data-loading/read/")[```typ #read(<path>, encoding: <encoding>)```],
  )[
    Read a file's content using the encoding specified. The ```typc <encoding>``` defaults to UTF-8, and the `read`
    function would return a string when the encoding is specified. Use ```typc encoding: none``` for reading and
    returning raw bytes.
  ],
  ..tr(
    link("https://typst.app/docs/reference/scripting/#modules")[```typ #include "<filename>"```],
  )[
    Include and evaluate the content of a Typst `.typ` file. Unlike C/C++'s ```c #include```, this is scoped.
  ],
  ..tr(
    link(
      "https://typst.app/docs/reference/text/raw/",
    )[```typ #raw(block: <boolean>, lang: <code-language>, <content>)```],
  )[
    Display a string as code block. Use ```typc block: true``` for block-level code, and specify
    ```typ <code-language>``` in the lang field. (e.g. ```typc "C++"``` for C++, and ```typc "rust"``` for Rust.)
  ],
  ..tr(
    link("https://typst.app/docs/reference/foundations/eval/")[```typ #eval(mode: <evaluation-mode>, <content>)```],
  )[
    Evaluate the ```typc <content>``` as Typst code using the ```typc <evaluation-mode>``` specified.
  ],
  table.cell(x: 1, rowspan: 6)[
    Functions for reading and processing data files. Those functions would return structured data. You can use the
    structured data and spread them into a table, evaluate them, or plot them. See #link(
      "https://typst.app/docs/reference/data-loading/",
    ) for details.
  ],
  [```typ #cbor(..)```],
  [```typ #csv(..)```],
  [```typ #json(..)```],
  [```typ #toml(..)```],
  [```typ #xml(..)```],
  [```typ #yaml(..)```],
)

A few examples include ```typ #table(columns: 3, ..csv("my_file.csv").flatten())``` for reading records and displaying
them and ```typ #raw(block: true, lang: "rust", read("my_file.rs"))``` for reading content from a Rust file in your
project's source code.

= Integrating Pagefind <pagefind-integration>

#link("https://pagefind.app/")[Pagefind] is a popular, fully static search library that is extremely convenient to use.
It works with any static HTML output, hence it works with Haita. It adds a bit of JavaScript overhead.

The default theme _New Hamber_ provides built-in support for Pagefind.

- / *Download Pagefind*: follow the steps in https://pagefind.app/docs/installation/#downloading-a-precompiled-binary or
    check if Pagefind is available in your package manager.

    After installing, you should be able to run Pagefind in the command line using the command `pagefind`.

- / *Enable _New Hamber_ integration*: Enable the `pagefind-enabled` setting in the html renderer as follows:
  ```typ
  #import "@preview/haita:...": book, new-hamber
  #book(
    html-renderer: new-hamber.html-renderer.with(
      pagefind-enabled: true,
    ),
    .. // your regular content
  )
  ```

- / *Running the Pagefind program*: After compiling your documentation, you need to run `pagefind` on your generated
    files. Suppose you have a `dist.typ` file and your output is in `./dist`, you'd need to run this command:

  ```sh
  pagefind --site ./dist --output-subdir pagefind
  ```

After you finished all of that, you should be able to see a pagefind searchbox in your main table of contents at the
left hand side.

= Embedding JavaScript

#let to-eval = ``````typ
// This uses tailwind
#html.div(id: "editor", class: "w-full h-40 border border-neutral-300")
#html.script(
  type: "module",
  {
    // This is the script used to setup the editor.
    // The editor is the Ace editor. See `https://ace.c9.io/` for detailsa
    let script-text = ```js
    import ace from "https://cdn.jsdelivr.net/npm/ace-builds@1/+esm";
    ace.config.set("basePath", "https://cdn.jsdelivr.net/npm/ace-builds@1/src-noconflict/");

    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/monokai");
    editor.session.setMode("ace/mode/javascript");
    ```.text
    script-text + "\n" + "editor.setValue(`" + script-text + "`)"
  },
)
``````

#context if target() == "html" [
  JavaScript is used for interactivity. Although Haita ships no client-side JS by default, you can still embed JS
  yourself. The following is an example of how to embed an editor in the document:

  #to-eval

  #eval(to-eval.text, mode: "markup")

  For the editor example specifically, you can even combine it with one of the many Typst packages that contains
  WebAssembly. For example, reading the content inside the editor #link(
    "https://github.com/ParaN3xus/typst-xcc-wrapper",
  )[then compiling it]. In this case, you would have to write the glue yourself.
] else [
  JS embedding would be demonstrated in the Web version. PDFs do support JavaScript; however, the support is extremely
  limited, and many PDF viewers would omit the JavaScript inside PDFs.
]
