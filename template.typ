#import "config.typ": website-name

#let default_template(id, name, body) = [
  #document(id + ".html", title: [#website-name - #name])[
    #html.html[
      #html.head[
        #html.meta(charset: "utf-8")
        #html.meta(name: "viewport", content: "width-device-with,initial-scale=1.0")
        #html.title[#website-name - #name]
        #html.script(src:"https://kit.fontawesome.com/eaf4181511.js", crossorigin: "anonymous")
        #html.link(rel: "stylesheet", href: "https://indestructibletype.com/fonts/Jost.css", type: "text/css")
        #html.link(rel: "stylesheet", href: "https://unpkg.com/normalize.css")
        #html.link(rel: "stylesheet", href: "/css/site.css")
      ]
      #html.body[
        #html.div(id: "blocks")[
          #html.div(id: "sidebar")[
            #html.div(id: "nav-links")[
              #html.div[
                #html.h1(id: "name")[
                  #link(<index>)[#website-name]
                ]]
              #html.nav[
                #html.div[#link(<index>)[Home]]
                #html.div[#link(<research>)[Research]]
                #html.div(class: "minor-nav")[#link(<libro-como>)[🕮 ¿Cómo?]]
                #html.div[#link(<talks>)[Talks]]
                #html.div[#link(<teaching>)[Teaching]]
                #html.div[#link(<cv>)[CV]]
                // #html.div(class: "minor-nav")[#link(<libro-como>)[🕮 Lógica para batitús]]
                // #html.div(class: "minor-nav")[#link(<workshop>)[Workshops]] 
                // #html.div(class: "minor-nav")[#link(<grupo-de-lectura>)[Grupos de lectura]]
                // #html.div[#link(<blog>)[Blog]]
                #html.div(style: "margin-top: 2em")[
                  #html.div(class: "minor-nav")[#link("mailto:ef.em.carbonell@gmail.com")[#html.i(class: "far fa-envelope") eml]]
                  #html.div(class: "minor-nav")[#link("https://scholar.social/@okf")[#html.i(class: "fab fa-mastodon") mstdn]]
                  #html.div(class: "minor-nav")[#link("https://bsky.app/profile/okfmoc.bsky.social")[#html.i(class: "fab fa-bluesky") blsky]]
                  #html.div(class: "minor-nav")[#link("https://github.com/fmoralesc")[#html.i(class: "fab fa-github") gthb]]
                ]
              ]
            ]
          ]
          #html.div(id: "content")[
            #body
          ]
        ]
      ]
    ]
  ] #label(id)
]

#let dated-li(date, details) = [
  #html.div(class: "dated-li")[
    #html.div(class: "dated-li-date")[#date]
    #html.div(class: "dated-li-details")[#details]
  ]

]
