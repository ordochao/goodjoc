template = require 'views/templates/cover'
View = require 'views/base/view'

module.exports = class CoverView extends View
  autoRender: yes
  className: 'mainContent cover'
  template: template