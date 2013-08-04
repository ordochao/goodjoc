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


  Handlebars.registerHelper("languageLinks",window.contentManager.getLanguageLinks )


  manageHeaderClick:(e)=>
    window.linkManager.manageHeaderClick(e);