' **** Script to control the row list item xml
sub init()
  m.itemposter = m.top.findNode("itemPoster") 
  m.itemmask = m.top.findNode("itemMask")
  m.itemlabel = m.top.findNode("itemLabel")
  m.itemMaskDescription = m.top.findNode("itemMaskDescription")
  m.itemDescriptionLabel = m.top.findNode("itemDescriptionLabel")
  m.itemDescriptionLabel.observeField("text", "onLabelContentChanged")
  m.rowlist = m.top.findNode("exampleRowList")
end sub

sub showcontent()
  itemcontent = m.top.itemContent
  m.itemposter.uri = itemcontent.HDPosterUrl
  m.itemlabel.text = itemcontent.title
  m.itemposter.url = itemcontent.url
  'parentContent = itemcontent.getParent()
  m.itemMaskDescription.visible = false
  if itemcontent.category = 0
     m.itemposter.width = "955"
     m.itemposter.height = "540"
     m.itemposter.translation = [ 465, 0 ]
     m.itemMask.width = m.itemposter.width + m.itemMaskDescription.width
     m.itemMask.height = "540"
     m.itemMask.translation = [0,0]
     m.itemlabel.width = m.itemMaskDescription.width
     m.itemlabel.translation = [10, 10]
     
  else
    m.itemposter.width = "382"
    m.itemposter.height = "214"
    m.itemMask.width = "384"
    m.itemMask.height = "216"
    m.itemlabel.width = m.itemMaskDescription.width
    m.itemposter.translation = [ 0, 0 ]
    m.itemMask.translation = [0,0]
    m.itemlabel.translation = [0,0]
  end if
end sub

sub showfocus()
  itemcontent = m.top.itemContent
  'scale = 1 + (m.top.focusPercent * 0.3)
  if itemcontent.category = 0
    m.itemMaskDescription.visible = true
    'm.itemDescriptionLabel.visible = true
    m.itemDescriptionLabel.text = itemcontent.description
    m.itemDescriptionLabel.width =  m.itemMaskDescription.width - 10
    'm.itemDescriptionLabel.height =  m.itemMaskDescription.height
    m.itemDescriptionLabel.opacity =  m.itemMaskDescription.opacity
  end if
  
  'print "scale content : " ; scale
  'm.itemposter.scale = [scale, scale]
end sub

sub showrowfocus()
  m.itemmask.opacity = 0.75 - (m.top.rowFocusPercent * 0.75)
  m.itemlabel.opacity = m.top.rowFocusPercent
end sub

sub onLabelContentChanged()
    print "Enters label content changed!"
end sub