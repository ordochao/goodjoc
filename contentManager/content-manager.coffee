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
    language = null
    language = contentManager.getCookieLanguage()
    if !language || language == undefined
      language = window.navigator.userLanguage || window.navigator.language;
    if !language || language == undefined
      language = cat
    contentManager.setCurrentDictionary(language)

  getCookieLanguage: () ->
    cookies = window.document.cookie.split(;)
    language = "cat"
    for cookie in cookies
      if cookie.indexOf("language=") != -1
        language = cookie.replace("language=","")
    return language

  parseCSVToFillDictionaries: (data) ->
    for entry in data
      @catalanDictionary[entry["key"]] = entry["català"]
      @castillianDictionary[entry["key"]] = entry["castellano"]
      @englishDictionary[entry["key"]] = entry["english"]

  setCurrentDictionary: (language) ->
    contentManager.currentIndex = 0
    if (language.indexOf "en") != -1
      contentManager.currentIndex = 2
    if (language.indexOf "cat") != -1
      contentManager.currentIndex = 0
    if (language.indexOf "es")  != -1
      contentManager.currentIndex = 1
    contentManager.currentDictionary = contentManager.dictionaries[contentManager.currentIndex]
  
  reload: () ->
    location.reload();

  updateHandlebars: () ->
    Handlebars.registerHelper('getContent', contentManager.getContent)


  getContent: (key) ->
    contentManager.currentDictionary[key]
