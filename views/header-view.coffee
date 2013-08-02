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

  openExternalLink:(url)  =>
    window.open(url,'_blank')

  openInternalLink:(url)  =>
    Backbone.history.navigate( url, {trigger:true} )

  manageHeaderClick:(e)=>
    e.preventDefault()
    console.log "Link on header clicked"
    console.log e
    url = e.currentTarget.getAttribute("href")
    if url.indexOf("http://") != -1 or url.indexOf("http://") != -1
        @.openExternalLink(url)
    else
        @.openInternalLink(url)    