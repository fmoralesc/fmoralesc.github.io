#import "template.typ": dated-li

#let bib_info_research(bibitem) = [
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
        if bibitem.at("volume", default: "") != "" { vol = [ #bibitem.volume]} else {let vol = ""}
        if bibitem.at("number", default: "") != "" { num = [(#bibitem.number)]} else {let num = ""}
        if bibitem.at("pages", default: "") != "" { pages = [, #bibitem.pages]} else {let pages = ""}
        if bibitem.at("coauthor", default: "") != "" { coauthor = [. (With #bibitem.coauthor)]} else {let coauthor = ""}
        if bibitem.at("extra", default: "") != "" { extra = [. #bibitem.extra]} else {let extra = ""}
        tail = [_#bibitem.journal _#vol#num#pages#coauthor#extra.]
    } else {
        tail = bibitem.extra
    }
    (#date). #title. #tail
]

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
    #dated-li(
      [#date],
      [#title. #tail]
    )
]

#let talk_info_cv(item) = [
    #dated-li(
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
