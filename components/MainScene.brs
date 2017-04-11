' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********  

sub init()
    m.top.backgroundURI = "pkg:/images/blueSky-background-fhd.jpg"
    m.videoPlayer       =   m.top.findNode("VideoPlayer")
    m.rowlist = m.top.findNode("exampleRowList")
    ' Load Scene Data from Server
    m.serverLoad = CreateObject("roSGNode", "ServerLoad")
    m.serverLoad.ObserveField("content", "onContentChanged")
    m.serverLoad.control = "RUN"
    m.top.SetFocus(true)
End sub

function onContentChanged() as void
    print "MainScene.onContentChanged : content changed!"
    m.rowlist.content = m.serverLoad.content
    m.rowlist.setFocus(true)
    m.rowlist.visible = true
end function

sub OnRowItemFocused()
    ' Obtain the actual focused content in the RowList
    'itemFocused = m.rowlist.content.getChild(m.rowlist.rowItemFocused[1])
    'print "item focused : " ; itemFocused    
end sub

' Listener to the item row selection in the RowList (OK button)
sub OnRowItemSelected()
    print "You selected an item!"
    ' Obtain the actual focused content in the RowList
    rowListItem = m.rowlist.content.getChild(m.rowlist.rowItemSelected[0])
    rowVideoItemSelected = rowListItem.getChild(m.rowlist.rowItemSelected[1])
    
    videoContent = CreateObject("RoSGNode", "ContentNode")
    videoContent.title = rowVideoItemSelected.title
    videoContent.url = rowVideoItemSelected.url
    videoContent.streamformat = "hls"
    m.videoPlayer.content = videoContent
    
    m.videoPlayer.visible = true
    m.videoPlayer.setFocus(true)
    m.videoPlayer.control = "play"
    m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
End sub

' Event function to listen the keys pressed in the Scene
function onKeyEvent(key as String, press as Boolean) as Boolean
   handled = false
   if (key = "back") then
     if (m.videoPlayer.visible = true) then
            m.videoPlayer.control = "stop"
            m.videoPlayer.visible = false
            ' Set the focus to the row list again...
            m.rowlist.SetFocus(true)
            handled = true
     end if
   end if
  return handled
end function

sub OnVideoPlayerStateChange()
    '? "MainScene > OnVideoPlayerStateChange : state == ";m.videoPlayer.state
    if m.videoPlayer.state = "error"
        'hide vide player in case of error
        m.videoPlayer.visible = false
        m.rowlist.SetFocus(true)
    else if m.videoPlayer.state = "playing"
    else if m.videoPlayer.state = "finished"
        'hide video player if video is finished
        m.videoPlayer.visible = false
        m.rowlist.SetFocus(true)
    end if
End sub
