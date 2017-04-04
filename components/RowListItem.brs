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
  print "contentParent.title: "; contentParent.title
  if contentParent.title = "Featured"
     print "enter the featured if"
     m.itemposter.width = "900"
     m.itemposter.height = "500"
     m.itemMask.width = "900"
     m.itemMask.height = "500"
  else
    m.itemposter.width = "380"
    m.itemposter.height = "200"
    m.itemMask.width = "380"
    m.itemMask.height = "200"
  end if
  print "heigth and width atributes: "; m.itemposter.width ; " - "; m.itemposter.height
end sub

sub showfocus()
  scale = 1 + (m.top.focusPercent * 0.3)
  m.itemposter.scale = [scale, scale]
end sub

sub showrowfocus()
  m.itemmask.opacity = 0.75 - (m.top.rowFocusPercent * 0.75)
  m.itemlabel.opacity = m.top.rowFocusPercent
end sub