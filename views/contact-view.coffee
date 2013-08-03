template = require 'views/templates/contact'
View = require 'views/base/view'

module.exports = class ContactView extends View
  autoRender: yes
  className: 'mainContent contact'
  template: template