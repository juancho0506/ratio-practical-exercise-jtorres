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
        featuredNode = generateGenericContentNodesFromJson(featured, featuredNode, 0)
    end if
    
    ' Generate Recent Nodes
    if (jsonResponse.recent <> invalid)
        recent = jsonResponse.recent
        'Generate a new row with child content nodes.
        recentNode = RowItems.createChild("ContentNode")
        recentNode = generateGenericContentNodesFromJson(recent, recentNode, 1)
    end if 
    
    ' Generate bonanza Nodes
    if (jsonResponse.bonanza <> invalid)
        bonanza = jsonResponse.bonanza
        'Generate a new row with child content nodes.
        bonanzaNode = RowItems.createChild("ContentNode")
        recentNode = generateGenericContentNodesFromJson(bonanza, bonanzaNode, 1)
    end if 

    return RowItems
end sub

' *** Method to generate in a generic way the content nodes for all the json nodes.
' * Category parameter stands for the category list row to show in this case : 0 - Featured style , 1 - Other ones.
sub generateGenericContentNodesFromJson(jsonNode as Object, contentNode as Object, category as integer) as Object
        ' Set the featured's title
        if jsonNode.title <> invalid
            contentNode.title = jsonNode.title
        end if
        ' Check the child nodes to generate the content for featured
        if jsonNode.items <> invalid
            for each item in jsonNode.items
                ' Append the new item child
                nodeChild = contentNode.createChild("RatioCustomNode")
                nodeChild.title = item.title
                nodeChild.description = item.description
                nodeChild.HDPosterUrl = item.image
                nodeChild.url = item.video
                nodeChild.streamformat = "hls"
                nodeChild.addField("category", "integer", false)
                nodeChild.category = category
            end for
        end if       
    return contentNode
end sub