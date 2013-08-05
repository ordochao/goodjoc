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
    if window.contentManager.currentIndex == 0 
      link += ' selected'
    link += '" href="lang=cat">cat</a>\n'
    link += '<a class="language-selector-link ' 
    if window.contentManager.currentIndex == 1
      link += ' selected'
    link += '" href="lang=es">cast</a>\n'
    link += '<a class="language-selector-link ' 
    if window.contentManager.currentIndex == 2
      link += ' selected'
    link += '" href="lang=en">en</a>\n'
    return link


  manageHeaderClick:(e)=>
    window.linkManager.manageHeaderClick(e);