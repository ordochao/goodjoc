# The content manager object.
module.exports = class ContentManager
  # Set your application name here so the document title is set to
  # “Controller title – Site title” (see Chaplin.Layout#adjustTitle)

  contentURL: "https://docs.google.com/spreadsheet/pub?key=0AuHaNdrjJxjZdGR0RWZGNV9lOW92ZXJ4Nkt5MnRtd0E&single=true&gid=0&output=csv"

  #Languages
  castillianDictionary: {}
  catalanDictionary: {}
  englishDictionary: {}
  dictionaries: []
  currentDictionary: {}
  currentIndex: 0

  initialize: ->
    contentManager.dictionaries = [contentManager.catalanDictionary,contentManager.castillianDictionary,contentManager.englishDictionary]
    d3.csv(@contentURL, @loadData)
    

  loadData: (data) ->
    contentManager.parseCSVToFillDictionaries(data)
    contentManager.updateHandlebars()
    contentManager.detectDefaultLanguage()
    window.application.initialize()

  detectDefaultLanguage: () ->
    language = window.navigator.userLanguage || window.navigator.language;
    if language.indexOf("en") != -1
      contentManager.setCurrentDictionary(2)
      return
    if language.indexOf("cat") != -1
      contentManager.setCurrentDictionary(0)
      return
    if language.indexOf("es") != -1
      contentManager.setCurrentDictionary(1)
      return

  parseCSVToFillDictionaries: (data) ->
    for entry in data
      @catalanDictionary[entry["key"]] = entry["català"]
      @castillianDictionary[entry["key"]] = entry["castellano"]
      @englishDictionary[entry["key"]] = entry["english"]

  setCurrentDictionary: (id) ->
    contentManager.currentIndex = id
    contentManager.currentDictionary = contentManager.dictionaries[id]
    contentManager.updateView()

  updateView: () ->
    console.log "updateView"
    links = document.getElementsByClassName('language-selector-link')
    for i in [0..links.length]
      link = links[i]
      if link
        console.log window.contentManager.currentIndex
        console.log i
        console.log i == parseInt(window.contentManager.currentIndex)
        if i == parseInt(window.contentManager.currentIndex)
          console.log "selected is " + i
          link.className = 'language-selector-link selected'
        else
          link.className = 'language-selector-link'



  updateHandlebars: () ->
    Handlebars.registerHelper('getContent', contentManager.getContent)


  getContent: (key) ->
    contentManager.currentDictionary[key]

  getLanguageLinks:(e)=>
    link  = '<a class="language-selector-link ' 
    if window.contentManager.currentIndex == 0 
      link += ' selected'
    link += '" href="lang=0">cat</a>\n'
    link += '<a class="language-selector-link ' 
    if window.contentManager.currentIndex == 1
      link += ' selected'
    link += '" href="lang=1">cast</a>\n'
    link += '<a class="language-selector-link ' 
    if window.contentManager.currentIndex == 2
      link += ' selected'
    link += '" href="lang=2">en</a>\n'
    console.log "link"
    console.log link
    return link
