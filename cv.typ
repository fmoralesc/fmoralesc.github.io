#import "@preview/fontawesome:0.6.1": *

#let bib_info_cv(bibitem) = [
    #let date = bibitem.date
    #let title = bibitem.title
    #let tail = ""
    // (#bibitem.date). #bibitem.title.
    #if bibitem.at("journal", default: "") != "" {
        let vol = ""
        let num = ""
        let pages = ""
        let coauthor = ""
        let extra = ""
        let url = ""
        if bibitem.at("volume", default: "") != "" { vol = [ #bibitem.volume]} else {let vol = ""}
        if bibitem.at("number", default: "") != "" { num = [(#bibitem.number)]} else {let num = ""}
        if bibitem.at("pages", default: "") != "" { pages = [, #bibitem.pages]} else {let pages = ""}
        if bibitem.at("coauthor", default: "") != "" { coauthor = [. (With #bibitem.coauthor)]} else {let coauthor = ""}
        if bibitem.at("extra", default: "") != "" { extra = [. #bibitem.extra]} else {let extra = ""}
        if bibitem.at("url", default: "") != "" { url = [. #link(bibitem.url)[#bibitem.url]]} else {let url = ""}
        tail = [_#bibitem.journal _#vol#num#pages#coauthor#extra#url.]
    } else {
        tail = bibitem.extra
    }
    #grid(columns: (1fr, 4fr),
      [#date],
      [#title. #tail]
    )
]

#let talk_info_cv(item) = [
    #grid(columns: (1fr, 4fr),
      [
        #let date = ""
        #if item.at("date", default: "") != "" {date = [, #item.date]}
        #item.year#date
      ],
      [
        #let location = ""
        #if item.at("location", default: "") != "" {location = [,
      #item.location]}
        #item.title. _#item.venue _#location.
      ]
    )
]

#let build_cv() = [
  #document("cv.pdf")[
    #set page(paper: "a4", margin: 2.5cm, numbering: "1")
    #set text(font: "Adobe Caslon Pro", lang: "en")
    #set par(justify: true)

    #show title: it => [
      #set text(font: "Jost*", weight: "regular")
      #align(center)[#it]
      #v(2em)
    ]

    #show heading: it => {
      set text(font: "Jost*")
      if it.level == 1 [
        #set text(weight: "regular", size: 16pt)
        #it
        #v(0.5em)
      ]
    }

    #show list: set block(inset: (left: 1em))

    #title[Felipe Morales Carbonell]

    = Contact

    #let personalia = yaml("_data/personalia.yml")

    #for line in personalia.address [
      #line.replace("</br>", "\n")
    ]

    #fa-icon("envelope") #link("mailto:" + personalia.email)

    #fa-icon("orcid") #link(personalia.orcid)


    = Short biography

    #personalia.bio

    _Area of Specialization_: #personalia.aos.

    _Areas of Competence_: #personalia.aoc.join(", ", last: ", and ")

    _Areas of Interest_: #personalia.aoi.join(", ", last: ", and ")

    = Education

    #stack(
      for degree in yaml("_data/education.yml").degrees [
        #grid(columns: (1fr, 4fr), 
          grid.cell()[#degree.dates],
          grid.cell()[
            #degree.description. #degree.place.

            #if degree.at("project", default: "") != "" [
              Project: _#degree.project._
            ]

            Thesis: _#degree.thesis._

            Supervisor: #degree.supervisor.

            #if degree.at("extra", default: "") != "" [
                #degree.extra.
            ]
          ]
        )
      ]
    )

    = Scholarships

    #stack(
      for scholarship in yaml("_data/scholarships.yml") [
        #grid(columns: (1fr, 4fr),
          [#scholarship.dates],
          [#scholarship.name. #scholarship.institution.],
        )
      ]
    )
    
    = Books

    #stack(
      for book in yaml("_data/books.yml") [
        #grid(columns: (1fr, 4fr),
          [#book.date],
          [
            #let extra = ""
            #let isbn = ""
            #let url = ""
            #if book.at("extra", default: "") != "" {
              extra = [ #book.extra.]
            }
            #if book.at("isbn", default: "") != "" {
              isbn = [ ISBN: #book.isbn.]
            }
            #if book.at("url", default: "") != "" {
              url = [ #link(book.url)[#book.url].]
            }
            _#book.title _.#extra#isbn#url
          ],
        )
      ]
    )

    = Articles

    #stack(
      for article in yaml("_data/articles.yml") [
        #bib_info_cv(article)
      ]
    )

    = Talks

    #stack(
      for article in yaml("_data/talks.yml") [
        #talk_info_cv(article)
      ]
    )

    #let others = yaml("_data/others.yml")

    = Organized events

    #stack(
      for event in others {
        if event.type == "event" [
          #grid(columns: (1fr, 4fr),
            [#event.date],
            [

              #let url = ""
              #if event.at("url", default: "") != "" {
                url = [. #link(event.url)[#event.url]]
              }
              _#event.title _. #event.venue#url.],
          )
        ]
      }
    )

    = Others
    
    #stack(
      for event in others {
        if event.type == "online" [
          #grid(columns: (1fr, 4fr),
            [#event.date],
            [

              #let url = ""
              #if event.at("url", default: "") != "" {
                url = [. #link(event.url)[#event.url]]
              }
              #event.title. _#event.extra _#url.],
          )
        ]
      }
    )

    = Editing/translation
    
    #stack(
      for event in others {
        if event.type == "edition" [
          #grid(columns: (1fr, 4fr),
            [#event.date],
            [

              #let url = ""
              #if event.at("url", default: "") != "" {
                url = [. #link(event.url)[#event.url]]
              }
              _#event.title _. #event.extra#url.],
          )
        ]
      }
    )

    = Teaching

    #stack(
      for pos in yaml("_data/teaching.yml") [
        #grid(columns: (1fr, 4fr),
          [#pos.date],
          [#pos.type. _#pos.course _ (#pos.level). #pos.place.]
        )
      ]
    )

    = Service and community
    
    #for service in personalia.service [
        #list.item[
        #service.kind:
        #for val in service.values [
          #list.item[#val]
        ]
        ]
        #v(0.2em)
      ]

    = Skills

    #for service in personalia.skills [
        #list.item[
        #service.name:
        #for val in service.values [
          #list.item[#val]
        ]
        ]
        #v(0.2em)
      ]

  ] <cv-pdf>
]


#let build_cv_simple() = [
  #document("cv-simple.pdf")[
    #set page(paper: "a4", margin: 2.5cm, numbering: "1")
    #set text(font: "Adobe Caslon Pro", lang: "en")
    #set par(justify: true)

    #show link: set text(fill: blue.darken(30%))

    #show title: it => [
      #set text(font: "Jost*", weight: "regular")
      #align(center)[#it]
      #v(2em)
    ]

    #show heading: it => {
      set text(font: "Jost*")
      if it.level == 1 [
        #set text(weight: "regular", size: 16pt)
        #it
        #v(0.5em)
      ]
    }

    #show list: set block(inset: (left: 1em))

    #title[Felipe Morales Carbonell]

    = Contacto

    #let personalia = yaml("_data/personalia.yml")

    #for line in personalia.address [
      #line.replace("</br>", "\n")
    ]

    #fa-icon("envelope") #link("mailto:" + personalia.email)

    = Biografía

    #personalia.bio_es

    = Educación

    #stack(
      for degree in yaml("_data/education.yml").degrees [
        #grid(columns: (1fr, 4fr), 
          grid.cell()[#degree.dates],
          grid.cell()[
            #degree.description.replace(
                            "Master in Philosophy, with specialization in Epistemology",
                            "Magíster en Filosofía"
                        ).replace(
                            "Bachelor in Philosophy",
                            "Licenciatura en Filosofía"
                        ). #degree.place.
          ]
        )
      ]
    )

    = Becas

    #stack(
      for scholarship in yaml("_data/scholarships.yml") [
        #grid(columns: (1fr, 4fr),
          [#scholarship.dates],
          [#scholarship.name. #scholarship.institution.],
        )
      ]
    )
    
    = Publicaciones y charlas

    Para detalles sobre mi carrera académica, véase mi currículum académico
        #link("https://fmoralesc.github.io/cv.pdf")

    #let others = yaml("_data/others.yml")

    = Organización de eventos

    #stack(
      for event in others {
        if event.type == "event" [
          #grid(columns: (1fr, 4fr),
            [#event.date.replace(", November 5", "").replace(", April 12", "")],
            [

              #let url = ""
              #if event.at("url", default: "") != "" {
                url = [. #link(event.url)[#event.url]]
              }
              _#{event.title}_.],
          )
        ]
      }
    )

    = Enseñanza

    #stack(
      for pos in yaml("_data/teaching.yml") [
        #grid(columns: (1fr, 4fr),
          [#pos.date],
          [#pos.type. _#pos.course _ (#pos.level). #pos.place.]
        )
      ]
    )

    = Habilidades

    #for service in personalia.skills [
        #list.item[
        #service.name.replace("Programming",
                    "Programación").replace("Typesetting", "Diagramación"):
        #for val in service.values [
          #list.item[#val]
        ]
        ]
        #v(0.2em)
      ]

  ] <cv-pdf-simple>
]
