@RestResource(urlMapping='/generateImages/*')
global  with sharing class generateImages {
@HttpPost
global static String createPDF(String contentPDF,String NamePdf)
{

    Blob body = EncodingUtil.base64Decode(contentPDF);

    Attachment attchRecord = new Attachment();
    attchRecord.Body = body;
    attchRecord.Name = NamePdf+'.jpg';
    attchRecord.isPrivate = false;
    attchRecord.ParentId  = '0010N00004IXnZQ';
    insert attchRecord;
    return attchRecord.Id;
}
    
@HttpGet
global static String sendImages()
{
    RestRequest request = RestContext.request;
    String idDocument = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
    List<Attachment> lstAttachment = [Select Body from Attachment where Id=:idDocument];
    return (!lstAttachment.isEmpty() ? EncodingUtil.base64Encode(lstAttachment[0].Body) : '');
}    
    
}