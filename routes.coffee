module.exports = (match) ->
  match '', 'home#index'
  match 'projects', 'home#projects'
  match 'about', 'home#about'
  match 'contact', 'home#contact'
  match 'projects/selectedProject/:idProject', 'home#selectProject'
