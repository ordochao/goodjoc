template = require 'views/templates/projects'
View = require 'views/base/view'


module.exports = class ProjectsView extends View
  autoRender: yes
  className: 'mainContent projects'
  template: template