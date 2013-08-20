Model = require 'models/base/model'

module.exports = class Project extends Model
  id: ""
  name: ""
  description: ""
  url_project: ""
  
  defaults:
    id: ""
    name: ""
    description: ""
    url_project: ""
    