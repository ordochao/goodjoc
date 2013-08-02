template = require 'views/templates/about'
View = require 'views/base/view'

module.exports = class AboutView extends View
  autoRender: yes
  className: 'mainContent about'
  template: template