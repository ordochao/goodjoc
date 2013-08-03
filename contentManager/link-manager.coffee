# The link manager object.
module.exports = class LinkManager
  # Set your application name here so the document title is set to
  # “Controller title – Site title” (see Chaplin.Layout#adjustTitle)
  openExternalLink:(url)  =>
    console.log url
    window.open(url,'_blank')

  openInternalLink:(url)  =>
    Backbone.history.navigate( url, {trigger:true} )

  manageHeaderClick:(e)=>
    e.preventDefault()
    console.log "Link on header clicked"
    console.log e
    url = e.currentTarget.getAttribute("href")
    if url.indexOf("lang=") !=-1
        @.changeLanguage(url.replace("lang=",""))
        return
    if url.indexOf("http://") != -1 or url.indexOf("http://") != -1
        @.openExternalLink(url)
        return
    else
        @.openInternalLink(url)    
        return

  changeLanguage: (id) =>
    window.contentManager.setCurrentDictionary(id)
    @.refresh()

  refresh: () =>
    location.reload();

  manageFooterClick:(e)=>
    e.preventDefault()
    console.log "Link on footer clicked"
    url = e.currentTarget.getAttribute("href")
    url = url.replace('\"', '')
    #url = "https://twitter.com/goodjoc"
    @.openExternalLink(url)