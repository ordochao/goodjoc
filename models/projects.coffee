Collection = require 'models/base/collection'
Project = require 'models/project'

module.exports = class Projects extends Collection
  #url: "https://docs.google.com/spreadsheet/pub?key=0AuHaNdrjJxjZdFVyMjlpTEwzWkl4YUpGbjBqZkVad1E&single=true&gid=0&output=csv"
  url : "/resources/projects.json"
  model: Project

  download: () =>
    console.log("downloading!")
    this.fetch()

  toJSON: () =>
    "TODO JSON"