Collection = require 'models/base/collection'
Project = require 'models/project'

module.exports = class Projects extends Collection
  url: "https://docs.google.com/spreadsheet/pub?key=0AuHaNdrjJxjZdFVyMjlpTEwzWkl4YUpGbjBqZkVad1E&single=true&gid=0&output=csv"
  model: Project

  download: () =>
    this.sync("create", this, {'url':this.url})

  toJSON: () =>
    "TODO JSON"