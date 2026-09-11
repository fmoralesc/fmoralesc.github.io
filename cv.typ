#import "@preview/fontawesome:0.6.1": *

#let dated_li(date, body) = [
    #grid(columns: (1.2fr, 4fr),
        [
            #set text(size: 0.9em, fill: black.lighten(20%))
            #date
        ],
        [   
            #body
        ]
    )
]

#let bib_info_cv(bibitem, lang: none) = [
    #let date = bibitem.date

    #if lang == "es" and type(date) == str {
      date = date.replace("forthcoming", "próximo")
    }

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
        let with = "With"
        if lang == "es" { with = "Con" } 
        if bibitem.at("coauthor", default: "") != "" { coauthor = [. (#with #bibitem.coauthor)]} else {let coauthor = ""}
        if bibitem.at("extra", default: "") != "" { extra = [. #bibitem.extra]} else {let extra = ""}
        if bibitem.at("url", default: "") != "" { url = [. #link(bibitem.url)[#bibitem.url]]} else {let url = ""}
        tail = [_#bibitem.journal _#vol#num#pages#coauthor#extra#url.]
    } else {
        tail = bibitem.extra
    }
    #dated_li(
      [#date],
      [#title. #tail]
    )
]

#let talk_info_cv(item, lang: none) = [
    #dated_li(
      [
        #let date = ""
        #if lang == "es" {
          if item.at("date_es", default: "") != "" {
            date = [, #item.date_es]
          }
        } else {
          if item.at("date", default: "") != "" {
            date = [, #item.date]
          }
        }
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
        #dated_li( 
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
        #dated_li(
          [#scholarship.dates],
          [#scholarship.name. #scholarship.institution.],
        )
      ]
    )
    
    = Books

    #stack(
      for book in yaml("_data/books.yml") [
        #dated_li(
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
            _#{book.title}_.#extra#isbn#url
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
          #dated_li(
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
          #dated_li(
            [#event.date],
            [

              #let url = ""
              #if event.at("url", default: "") != "" {
                url = [. #link(event.url)[#event.url]]
              }
              #event.title. _#{event.extra}_#url.],
          )
        ]
      }
    )

    = Editing/translation
    
    #stack(
      for event in others {
        if event.type == "edition" [
          #dated_li(
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
        #dated_li(
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

    #columns(2)[
    #for service in personalia.skills [
        #list.item[
        #service.name:
        #for val in service.values [
          #list.item[#val]
        ]
        ]
        #colbreak()
      ]
    ]

  ] <cv-pdf>
]


#let build_cv_es() = [
  #document("cv-es.pdf")[
    #set page(paper: "a4", margin: 2.5cm, numbering: "1")
    #set text(font: "Adobe Caslon Pro", lang: "es")
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

    = Datos de contacto

    #let personalia = yaml("_data/personalia.yml")

    #for line in personalia.address [
      #line.replace("</br>", "\n")
    ]

    #fa-icon("envelope") #link("mailto:" + personalia.email)

    #fa-icon("orcid") #link(personalia.orcid)


    = Biografía breve

    #personalia.bio_es

    _Area de Especialización_: #personalia.aos_es.

    _Areas de Competencia_: #personalia.aoc_es.join(", ", last: ", y ")

    _Areas de Interés_: #personalia.aoi_es.join(", ", last: ", y ")

    = Educación

    #stack(
      for degree in yaml("_data/education.yml").degrees [
        #dated_li( 
          grid.cell()[#degree.dates],
          grid.cell()[
            #degree.description.replace(
                            "Master in Philosophy, with specialization in Epistemology",
                            "Magíster en Filosofía"
                        ).replace(
                            "Bachelor in Philosophy",
                            "Licenciatura en Filosofía"
                        ). #degree.place.

            #if degree.at("project", default: "") != "" [
              Project: _#degree.project._
            ]

            Tesis: _#degree.thesis._

            Supervisor: #degree.supervisor.

            // #if degree.at("extra", default: "") != "" [
            //     #degree.extra.
            // ]
          ]
        )
      ]
    )

    = Becas

    #stack(
      for scholarship in yaml("_data/scholarships.yml") [
        #dated_li(
          [#scholarship.dates],
          [#scholarship.name. #scholarship.institution.],
        )
      ]
    )
    
    = Libros

    #stack(
      for book in yaml("_data/books.yml") [
        #dated_li(
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
            _#{book.title}_.#extra#isbn#url
          ],
        )
      ]
    )

    = Artículos

    #stack(
      for article in yaml("_data/articles.yml") [
        #bib_info_cv(article, lang: "es")
      ]
    )

    = Charlas y presentaciones

    #stack(
      for article in yaml("_data/talks.yml") [
        #talk_info_cv(article, lang: "es")
      ]
    )

    #let others = yaml("_data/others.yml")

    = Eventos organizados

    #stack(
      for event in others {
        if event.type == "event" [
          #dated_li(
            [#event.date.replace("November", "Noviembre").replace("April", "Abril")],
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

    = Otros
    
    #stack(
      for event in others {
        if event.type == "online" [
          #dated_li(
            [#event.date],
            [

              #let url = ""
              #if event.at("url", default: "") != "" {
                url = [. #link(event.url)[#event.url]]
              }
              #event.title. _#{event.extra}_#url.],
          )
        ]
      }
    )

    = Edición/traducción
    
    #stack(
      for event in others {
        if event.type == "edition" [
          #dated_li(
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

    = Enseñanza

    #stack(
      for pos in yaml("_data/teaching.yml") [
        #dated_li(
          [#pos.date],
          [#pos.type. _#pos.course _ (#pos.level). #pos.place.]
        )
      ]
    )

    = Servicio y comunidad
    
    #for service in personalia.service [
        #list.item[
        #service.kind_es:
        #for val in service.values [
          #list.item[#val]
        ]
        ]
        #v(0.2em)
      ]

    = Habilidades

    #columns(2)[
    #for service in personalia.skills [
        #list.item[
        #service.name:
        #for val in service.values [
          #list.item[#val]
        ]
        ]
        #colbreak()
      ]
    ]

  ] <cv-pdf-es>
]


#let build_cv_short() = [
  #document("cv-short.pdf")[
    #set page(paper: "a4", margin: 1.5cm, numbering: "1")
    #set text(font: "Adobe Caslon Pro", lang: "en", size: 9pt)
    #set par(justify: true)

    #show title: it => [
      #set text(font: "Jost*", weight: "regular", size: 14pt)
      #align(center)[#it]
      #v(2em)
    ]

    #show heading: it => {
      set text(font: "Jost*")
      if it.level == 1 [
        #set text(weight: "regular", size: 11pt)
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
        #dated_li( 
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
        #dated_li(
          [#scholarship.dates],
          [#scholarship.name. #scholarship.institution.],
        )
      ]
    )
    
    = Books

    #stack(
      for book in yaml("_data/books.yml") [
        #dated_li(
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
            _#{book.title}_.#extra#isbn#url
          ],
        )
      ]
    )

    = Articles

    #stack(
      for article in yaml("_data/articles.yml") [
        #if article.at("date") == "forthcoming" or int(article.at("date")) > 2022 [
            #bib_info_cv(article)
        ]
      ]
    )

    #let others = yaml("_data/others.yml")

    = Teaching

    #stack(
      for pos in yaml("_data/teaching.yml") [
        #dated_li(
          [#pos.date],
          [#pos.type. _#pos.course _ (#pos.level). #pos.place.]
        )
      ]
    )

  ] <cv-short-pdf>
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
      #v(0.5em)
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

    #align(center)[
        CURRICULUM VITAE
    ]

    #title[Felipe Morales Carbonell]

    #align(center)[
        RUT: 16.303.890-0
    ]

    = Contacto

    #let personalia = yaml("_data/personalia.yml")

    #for line in personalia.address [
      #line.replace("</br>", "\n")
    ]

    #fa-icon("envelope") #link("mailto:" + personalia.email)

    #fa-icon("phone") #link("tel:+56948491502")[+56-9-48491502]

    = Biografía

    #personalia.bio_es

    = Educación

    #stack(
      for degree in yaml("_data/education.yml").degrees [
        #dated_li( 
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
        #dated_li(
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
          #dated_li(
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
        #dated_li(
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
