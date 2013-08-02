View = require 'views/base/view'
template = require 'views/templates/site'


imageURL = () -> "pictures/background/"+Math.round(16*Math.random()+1)+".JPG"

Handlebars.registerHelper('imageURL', imageURL )

# Site view is a top-level view which is bound to body.
module.exports = class SiteView extends View
  container: 'body'
  id: 'site-container'
  regions:
    '#header-container': 'header'
    '#page-container': 'main'
    '#site-container': 'all'
    '#footer-container': 'footer'
  template: template
