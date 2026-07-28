#title[References]
#import "@preview/tidy:0.4.3"

References for functions and methods in Haita.

#let haita = tidy.parse-module(read("../lib.typ"), name: "haita")
#let new-hamber = tidy.parse-module(read("../new-hamber.typ"), name: "new-hamber")

#let get-type-html(ty) = {
  let c = (
    "str": "bg-green-300/60",
    "chapter": "bg-red-300/60",
    "content": "bg-teal-300/60",
    "auto": "bg-red-300/60",
    "any": "bg-neutral-300/60",
    "array": "bg-fuchsia-300/60",
    "function": "bg-indigo-300/60",
    "bool": "bg-orange-300/60",
  ).at(ty, default: "bg-neutral-300/60")
  html.span(class: "py-[2px] px-[4px] mr-1 rounded-sm font-mono text-sm font-normal " + c, ty)
}

#for module in (haita, new-hamber) {
  divider()
  for func-def in module.functions {
    [#heading(level: 1, html.span(class: "font-mono", func-def.name)) #label(module.label-prefix + func-def.name)]

    eval(func-def.description, mode: "markup")

    html.pre[
      #func-def.name\(
      #html.div(class: "ml-[2ch]", for (key, val) in func-def.args {
        html.span(class: "block", {
          if "default" in val {
            [#(key): ]
            raw(lang: "typc", val.default)
            [ ]
          }
          for type in val.at("types", default: ()) {
            get-type-html(type)
          }
          [,]
        })
      })
      \)
      #if func-def.return-types != none {
        [ -> ]
        for ty in func-def.return-types {
          get-type-html(ty)
        }
      }
    ]

    heading(level: 2)[Parameters]

    if func-def.args.len() == 0 [
      _This function does not have any parameters._
      #continue
    ]

    for (key, val) in func-def.args {
      heading(level: 3, {
        html.span(class: "font-mono mr-8", key)
        val.at("types", default: ()).map(get-type-html).join(html.span(class: "text-xs mr-1")[or])
        if "default" not in val {
          html.span(class: "ml-3 text-xs", [_Positional_])
        }
      })
      eval(val.description, mode: "markup")
    }
  }
}
