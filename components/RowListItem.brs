' **** Script to control the row list item xml
sub init()
  m.itemposter = m.top.findNode("itemPoster") 
  m.itemmask = m.top.findNode("itemMask")
  m.itemlabel = m.top.findNode("itemLabel")
end sub

sub showcontent()
  itemcontent = m.top.itemContent
  contentParent = itemcontent.getParent()
  m.itemposter.uri = itemcontent.HDPosterUrl
  m.itemlabel.text = itemcontent.title
  m.itemposter.url = itemcontent.url
  if contentParent.title = "Featured"
     m.itemposter.width = "960"
     m.itemposter.height = "540"
     m.itemMask.width = "960"
     m.itemMask.height = "540"
     m.itemlabel.width = m.itemposter.width
     m.itemlabel.translation = [0, 450]
  else
    m.itemposter.width = "384"
    m.itemposter.height = "216"
    m.itemMask.width = "384"
    m.itemMask.height = "216"
    m.itemlabel.width = m.itemposter.width
    m.itemlabel.translation = [0, 180]
  end if
end sub

sub showfocus()
  scale = 1 + (m.top.focusPercent * 0.3)
  'm.itemposter.scale = [scale, scale]
end sub

sub showrowfocus()
  m.itemmask.opacity = 0.75 - (m.top.rowFocusPercent * 0.75)
  m.itemlabel.opacity = m.top.rowFocusPercent
end sub