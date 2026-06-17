#import "template.typ": dated-li, default_template
#import "bib.typ": bib_info_cv, bib_info_research, talk_info_cv

#default_template("index", [Home])[
  = About me

  I am a philosopher. I just finished a postdoctoral researcher position at
  Universidad de Chile. Originally from Santiago (Chile), I pursued my PhD at KU
  Leuven's Institute of Philosophy (Belgium), where I also did my MPhil. I
  mainly work in topics related to (i) the philosophy of modality, specially its
  epistemology and metaphysics, (ii) understanding, and (iii) know-how. I also
  am competent in general epistemology, philosophy of science, philosophy of
  logic and philosophical logic.

  In my spare time, I draw, play guitar and contribute to various open source
  projects.

  #html.div(id: "image-self")[#html.img(src: "assets/avatar.png")]
]

#default_template("research", [Research])[
  #html.div(class: "wrapper")[
    #html.section(class: "main")[
      #html.div(style: "padding-right: 2em")[
        //first column
        #html.section[
          #html.h2[Publications]

          A selection of representative papers (click to see the abstracts).

          #for article in yaml("_data/articles.yml") {
            if (
              article.at("selected", default: false)
                and article.selected == true
            ) [
              #html.details()[
                #html.summary[
                  #bib_info_research(article)
                  #if article.at("url", default: "") != "" [
                    #link(article.url)[\[url\]]
                  ]
                  #if article.at("local", default: "") != "" [
                    #link("/assets/" + article.local)[\[pdf\]]
                  ]
                ]
                #html.div(class: "abstract")[#article.abstract]
              ]
            ]
          }
        ]
        #html.section[
          #html.h2[Manuscripts]

          Some odds and ends.

          #for ms in yaml("_data/manuscripts.yml") {
            html.details()[
              #html.summary[
                #ms.title. #link(ms.url)[\[pdf\]]
              ]
            ]
          }
        ]
      ]
      #html.div[
        // second column
        #html.section(class: "first-section")[
          #html.h2[#html.small[Postdoctoral project:]#html.br()Saber Cómo:
            Preguntas, Maneras e Intentos]

          2022-2025. Universidad de Chile.

          #link(
            "/assets/postdoc - saber como: preguntas, maneras e intentos - resumen (es).pdf",
          )[Summary (spanish) [pdf]]

          === Book: _¿Cómo? Una Introducción a la Epistemología del Saber-Cómo_

          #link(<libro-como>)[[more info]] #link("/assets/como.pdf")[[download]]
        ]

        #html.section[
          #html.h2[#html.small[PhD Thesis]#html.br()Agentive Modality and the
            Structure of Modal Thought.]

          2017--2021. KU Leuven.

          This thesis develops a theory about the structure of modal judgment
          and knowledge. Arguing in favor of pluralism about the source of modal
          knowledge, it focuses on the questions of the varieties of modal
          judgement and their relations, the function of modal judgement and the
          scope of modal knowledge. It offers a hypothesis about the development
          of the framework of modal knowledge, grounding it on the capacity to
          evaluate temporal judgements, from which the capacity to evaluate
          alternatives comes from. It suggests that the most basic framework of
          modal judgements consists in that of agentive modality, and in
          particular, about what one can do, and how. It is argued that the rest
          of the framework of modal judgement can be developed on this basis,
          although this imposes certain restrictions about the scope of modal
          knowledge. Additionally, the thesis provides analyses of various
          agentive modal notions, such as imaginability, what is a way to do
          something, and discusses how to understand counterfactuals with
          impossible antecedents.
        ]
      ]
    ]
  ]
]


#default_template("talks", [Talks])[
  #html.section[
    #html.h2[Talks]

    #html.div(id: "dated-list")[
      #for talk in yaml("_data/talks.yml") {
        if talk.at("selected", default: false) [
          #html.div(class: "dated-li")[
            #html.div(class: "dated-li-date")[#talk.year, #talk.date]
            #html.div(class: "dated-li-details")[#talk.title. _#talk.venue _,
              #talk.location.]
          ]
        ]
      }
    ]
  ]
]

#default_template("teaching", [Teaching])[
    #html.section[
        #html.h2[Teaching]

        #html.div(id: "dated-list")[
            #for pos in yaml("_data/teaching.yml") [
                #html.div(class: "dated-li")[
                    #html.div(class: "dated-li-date")[#pos.date]
                    #html.div(class: "dated-li-details")[
                        #pos.type. _#pos.course _ (#pos.level). #pos.place.
                    ]
                ]
            ]
        ]
    ]
]

#default_template("cv", [CV])[
  #let personalia = yaml("_data/personalia.yml")

  #html.section[
    = Contact

    // #personalia

    #for line in personalia.address [
      #line.replace("</br>", "\n")
    ]

    #html.i(class: "far fa-envelope")[] #html.a(
      href: "mailto" + personalia.email,
    )[#personalia.email]

    #html.i(class: "fa-brands fa-orcid")[] #link(
      personalia.orcid,
    )[#personalia.orcid]

    = Short biography

    #personalia.bio

    _Area of Specialization_: #personalia.aos.


    _Areas of Competence_: #personalia.aoc.join(", ", last: ", and ")

    _Areas of Interest_: #personalia.aoi.join(", ", last: ", and ")

    = Education

    #html.div(class: "dated-list")[
      #for degree in yaml("_data/education.yml").degrees [
        #dated-li(
          [
            #degree.dates
          ],
          [
            #degree.description, #degree.place.

            #if degree.at("project", default: "") != "" [
              Project: _#degree.project._
            ]

            Thesis: _#degree.thesis._

            #html.p(class: "li-extra-info")[
              Supervisor: #degree.supervisor.
            ]
            #if degree.at("extra", default: "") != "" [
              #html.p(class: "li-extra-info")[
                #degree.extra.
              ]
            ]
          ],
        )
      ]
    ]

    = Scholarships

    #html.div(class: "dated-list")[
      #for scholarship in yaml("_data/scholarships.yml") [
        #dated-li(
          [#scholarship.dates],
          [#scholarship.name. #scholarship.institution.],
        )
      ]
    ]

    = Books

    #html.div(class: "dated-list")[
      #for book in yaml("_data/books.yml") [
        #dated-li(
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
    ]

    = Articles

    #html.div(class: "dated-list")[
      #for article in yaml("_data/articles.yml") [
        #bib_info_cv(article)
      ]
    ]

    = Talks

    #html.div(class: "dated-list")[
      #for article in yaml("_data/talks.yml") [
        #talk_info_cv(article)
      ]
    ]

    #let others = yaml("_data/others.yml")

    = Organized events


    #html.div(class: "dated-list")[
      #for event in others {
        if event.type == "event" [
          #dated-li(
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
    ]

    = Others

    #html.div(class: "dated-list")[
      #for item in others {
        if item.type == "online" [
          #dated-li(
            [#item.date],
            [
              #let url = ""
              #if item.at("url", default: "") != "" {
                url = [.
                  #link(item.url)[#item.url]]
              }
              #item.title. _#item.extra _#url.],
          )
        ]
      }
    ]

    = Editing/translation

    #html.div(class: "dated-list")[
      #for item in others {
        if item.type == "edition" [
          #dated-li(
            [#item.date],
            [
              #let url = ""
              #if item.at("url", default: "") != "" {
                url = [.
                  #link(item.url)[#item.url]]
              }
              _#item.title _. #item.extra#url.],
          )
        ]
      }
    ]

    = Teaching experience

    #html.div(id: "dated-list")[
      #for pos in yaml("_data/teaching.yml") [
        #html.div(class: "dated-li")[
          #html.div(class: "dated-li-date")[#pos.date]
          #html.div(class: "dated-li-details")[
            #pos.type. _#pos.course _ (#pos.level). #pos.place.
          ]
        ]
      ]
    ]

    = Service and community

    #html.ul[
      #for service in personalia.service [
        #html.li[#service.kind]
        #html.ul[
          #for val in service.values [
            #html.li[#val]
          ]
        ]
      ]
    ]

    = Skills

    #html.ul[
      #for skill in personalia.skills [
        #html.li[#skill.name]
        #html.ul[
          #for val in skill.values [
            #html.li[#val]
          ]
        ]
      ]
    ]

  ]
]

#default_template("libro-como", [¿Cómo?])[

  = ¿Cómo? \ _Una Introducción a la Epistemología del Saber-Cómo_

  Una introducción a la epistemología del saber-cómo, en español.

  Parte del projecto ANID/Postdoctorado 3220017 'Saber-Cómo: Preguntas, Maneras,
  Intentos' (2022-2025).

  #html.embed(width: 630, height: 400, src: "/assets/como.pdf")

  == Tabla de contenidos

  + Enfrentando la imagen manifiesta. Una introducción a la metodología
    filosófica contemporánea.
  + Un modelo tentador. Una introducción a la epistemología post-Gettier y un
    modelo intelectualista del saber-cómo
  + Combatiendo un mito. Los argumentos de Ryle contra el intelectualismo.
  + La disputa de las cien escuelas. Los nuevos intelectualismos, el problema
    del testimonio, el problema de la suerte epistémica, la importancia del
    contexto, el saber-cómo como logro epistémico
  + Ciencia cognitiva y saber-cómo. Representacionalismo y
    anti-representacionalismo, la posibilidad del saber-cómo artificial.
  + Usando el mundo. Saber cómo y la hipótesis de la mente extendida.
  + Haciendo cosas en conjunto. Saber-cómo colectivo, social y científico.
  + Impedimentos. Injusticia epistémica y vicios epistémicos.
  + Otras epistemologías. Etnoepistemología, epistemología mapuche.

  Incluye preguntas y respuestas seleccionadas, y un apéndice sobre lógica
  básica.

  descargar: #link("/assets/como.pdf")[[pdf]]

  código fuente: #link("https://github.com/montbretia/como-libro")[\@github]


  // <embed width="100%" height="990" src="../assets/como.pdf">
]

// #default_template("workshop", [Workshop])[]

// #default_template("grupo-de-lectura", [Grupos de lectura])[]

// #default_template("blog", [Blog])[]

#asset("css/site.css", read("css/site.css"))

#asset("assets/avatar.png", read("docs/assets/avatar2.png", encoding: none))
#asset("assets/como.pdf", read("docs/assets/como.pdf", encoding: none))
