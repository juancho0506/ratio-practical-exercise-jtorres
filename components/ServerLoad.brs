sub init()
    m.top.functionName = "executeTask"
end sub

function executeTask() as void
    jsonResponse = getServerJsonResponse()    
    'Set the content to the scene Node 
    m.top.content = generateContentNodeFromJson(jsonResponse)
    print "ServerLoad.content" ; m.top.content
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
        featuredNode = createObject("RoSGNode","ContentNode")
        'print "featured: "; featured
        ' Set the featured's title
        if featured.title <> invalid
            featuredNode.title = featured.title
        end if
        ' Check the child nodes to generate the content for featured
        if featured.items <> invalid
            for each item in featured.items
                featuredChild = createObject("RoSGNode","ContentNode")
                featuredChild.title = item.title
                featuredChild.description = item.description
                featuredChild.HDPosterUrl = item.image
                featuredChild.url = item.video
                ' Append the new item child
                print "featuredChild : " ; featuredChild
                featuredNode.appendChild(item)
            end for
        end if
        print "featuredNode : " ; featuredNode
        RowItems.appendChild(featuredNode)
        
    end if

    return RowItems
end sub