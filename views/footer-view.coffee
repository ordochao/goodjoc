View = require 'views/base/view'
template = require 'views/templates/footer'

module.exports = class HeaderView extends View
  autoRender: yes
  className: 'footer'
  region: 'footer'
  id: 'footer'
  template: template


  events:
    "click a": "manageFooterClick"


  manageFooterClick:(e)=>
    console.log "click on footer"
    window.linkManager.manageFooterClick(e);
