sub init()
    m.top.functionName = "executeTask"
end sub

function executeTask() as void
    jsonResponse = getServerJsonResponse()    
    'Set the content to the scene Node 
    m.top.content = generateContentNodeFromJson(jsonResponse)
end function

' Function that retrieves the server data..
sub getServerJsonResponse() as Object
    url = CreateObject("roUrlTransfer")
    ' Set https certificate
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    url.AddHeader("X-Roku-Reserved-Dev-Id", "")
    url.InitClientCertificates()
    
    url.SetUrl("https://ratiointeractive.github.io/Roku-DeveloperDocs/api.json")
    ' The response from the server...
    rsp = url.GetToString()
    ' The JSON object parsed from response.
    responseJSON = ParseJSON(rsp)
    return responseJSON
End sub

' Generate Content Nodes to Scene's RowList
sub generateContentNodeFromJson(jsonResponse as Object) as Object
    RowItems = createObject("RoSGNode","ContentNode")
    
    ' Generate Featured Nodes
    if (jsonResponse.featured <> invalid)
        featured = jsonResponse.featured
        'Generate a new row with child content nodes.
        featuredNode = RowItems.createChild("ContentNode")
        'featuredNode = generateGenericContentNodesFromJson(featured)
        ' Set the featured's title
        if featured.title <> invalid
            featuredNode.title = featured.title
        end if
        ' Check the child nodes to generate the content for featured
        if featured.items <> invalid
            for each item in featured.items
                ' Append the new item child
                nodeChild = featuredNode.createChild("ContentNode")
                nodeChild.title = item.title
                nodeChild.description = item.description
                nodeChild.HDPosterUrl = item.image
                nodeChild.url = item.video
                nodeChild.streamformat = "hls"
            end for
        end if
    end if
    
    ' Generate Recent Nodes
    if (jsonResponse.recent <> invalid)
        recent = jsonResponse.recent
        'Generate a new row with child content nodes.
        recentNode = RowItems.createChild("ContentNode")
        'recentNode = generateGenericContentNodesFromJson(recent)
        
        ' Set the featured's title
        if recent.title <> invalid
            recentNode.title = recent.title
        end if
        ' Check the child nodes to generate the content for featured
        if recent.items <> invalid
            for each item in recent.items
                ' Append the new item child
                nodeChild = recentNode.createChild("ContentNode")
                nodeChild.title = item.title
                nodeChild.description = item.description
                nodeChild.HDPosterUrl = item.image
                nodeChild.url = item.video
                nodeChild.streamformat = "hls"
            end for
        end if
    end if 
    
    ' Generate bonanza Nodes
    if (jsonResponse.bonanza <> invalid)
        bonanza = jsonResponse.bonanza
        'Generate a new row with child content nodes.
        bonanzaNode = RowItems.createChild("ContentNode")
        'recentNode = generateGenericContentNodesFromJson(recent)

        ' Set the featured's title
        if bonanza.title <> invalid
            bonanzaNode.title = bonanza.title
        end if
        ' Check the child nodes to generate the content for featured
        if bonanza.items <> invalid
            for each item in bonanza.items
                ' Append the new item child
                nodeChild = bonanzaNode.createChild("ContentNode")
                nodeChild.title = item.title
                nodeChild.description = item.description
                nodeChild.HDPosterUrl = item.image
                nodeChild.url = item.video
                nodeChild.streamformat = "hls"
            end for
        end if
    end if 

    return RowItems
end sub

' *** Method to generate in a generic way the content nodes for all the json nodes.
sub generateGenericContentNodesFromJson(jsonNode as Object) as Object
    topNode = createObject("RoSGNode","ContentNode")
        ' Set the featured's title
        if jsonNode.title <> invalid
            topNode.title = jsonNode.title
        end if
        ' Check the child nodes to generate the content for featured
        if jsonNode.items <> invalid
            for each item in jsonNode.items
                ' Append the new item child
                nodeChild = topNode.createChild("ContentNode")
                nodeChild.title = item.title
                nodeChild.description = item.description
                nodeChild.HDPosterUrl = item.image
                nodeChild.url = item.video
                nodeChild.streamformat = "hls"
            end for
        end if       
    return topNode
end sub