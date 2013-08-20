View = require 'views/base/view'
template = require 'views/templates/header'

module.exports = class HeaderView extends View
  autoRender: yes
  className: 'header'
  region: 'header'
  id: 'header'
  template: template

  events:
    "click a": "manageHeaderClick"



  constructor: () ->
    Handlebars.registerHelper("languageLinks",@getLanguageLinks )  
    super

  
  getLanguageLinks: () =>
    link  = '<a class="language-selector-link ' 
    if goodjoc.managers.contentManager.currentIndex == 0 
      link += ' selected'
    link += '" href="lang=cat">cat</a>\n'
    link += '<a class="language-selector-link ' 
    if goodjoc.managers.contentManager.currentIndex == 1
      link += ' selected'
    link += '" href="lang=es">cast</a>\n'
    link += '<a class="language-selector-link ' 
    if goodjoc.managers.contentManager.currentIndex == 2
      link += ' selected'
    link += '" href="lang=en">en</a>\n'
    return link


  manageHeaderClick:(e)=>
    goodjoc.managers.linkManager.manageHeaderClick(e);
    links = document.getElementsByClassName ("header-link") 
    for link in links
      if link == e.target
        link.className = "header-link selected"
      else 
        link.className = "header-link"