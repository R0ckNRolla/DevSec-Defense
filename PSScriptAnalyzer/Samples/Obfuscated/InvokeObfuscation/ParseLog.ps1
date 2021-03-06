$fileoffset=300
$structSz = 48
$cbWebAppGuid = 36 
$cbSiteGuid   = 36 
$cbTimeStamp  = 8
$enc = [System.Text.Encoding]::ASCII

if($args.length -eq 0)
{
	W`RITe-oU`TpUt "Error provide the path of log as argument to the script.  Usage : Parselog filepath "
	exit 0
}
$index = 1
$content = G`ET`-CONte`NT -encoding byte $args[0]

$logItem= @{ datastruct = @{	pprev    = 0;
				bitFlags = 0; 								
				cbEntry  =0;	
				cbSiteUrl=0;
				cbWeb=0;
				cbDoc=0;
				cBytes=0;
				httpStatus=0;
				cbUser=0;
				cbRefQS=0;
				cbRef=0;
				cbUAS=0;
				cbQS=0;
				cbVersion=0;
				reserved=0
			}
		GUID 		= "";
		cbEntrySize 	= 0;
		timeStamp	= "";	
		siteurl		= "";
		web		= "";
		doc		= "";
		user		= "";
		}

$offset=300
$structOffset=0


while($fileoffset -lt $content.length)
{
    
	$structoffset = $fileoffset
	$offset= $structSz + 2+ $fileoffset
	$logItem["datastruct"]["pprev"]= [System.Bitconverter]::ToInt64($content,$structoffset)
	$structOffset=	$structOffset +	8
	
	$logItem["datastruct"]["bitFlags"] = $content[$structoffset]	
	$structOffset=	$structOffset +	2
	
	$logItem["datastruct"]["cbEntry"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2

		
	$logItem["datastruct"]["cbSiteUrl"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2

	
	$logItem["datastruct"]["cbWeb"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2

	$logItem["datastruct"]["cbDoc"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	4

	
	$logItem["datastruct"]["cBytes"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	4

	$logItem["datastruct"]["httpStatus"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2

	
	$logItem["datastruct"]["cbUser"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2

	$logItem["datastruct"]["cbRefQS"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2

	
	$logItem["datastruct"]["cbRef"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2

	$logItem["datastruct"]["cbUAS"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2

	
	$logItem["datastruct"]["cbQS"]= [System.Bitconverter]::ToInt16($content,$structoffset)
	$structOffset=	$structOffset +	2
	
	$logItem["cbEntrySize"]	= $structSz + $cbWebAppGuid + $cbSiteGuid + $cbTimeStamp`
    + $logItem["datastruct"]["cbSiteUrl"]+ $logItem["datastruct"]["cbWeb"] `
    + $logItem["datastruct"]["cbDoc"]  + $logItem["datastruct"]["cbUser"] `
    + $logItem["datastruct"]["cbQS"]  + $logItem["datastruct"]["cbRefQS"] `
    + $logItem["datastruct"]["cbRef"] + $logItem["datastruct"]["cbUAS"] + 13;
                
    $logItem["GUID"]   = $enc.GetString($content,$offset,$cbSiteGuid)  
    $offset= $offset+ $cbSiteGuid +1
    
    $logItem["timeStamp"]   = $enc.GetString($content,$offset,$cbTimeStamp)  
    $offset= $offset+ $cbTimeStamp +1
    
    $logItem["siteUrl"]   = $enc.GetString($content,$offset,$logItem["datastruct"]["cbSiteUrl"] )  
    $offset= $offset+ $logItem["datastruct"]["cbSiteUrl"] +1
    
    $logItem["web"]   = $enc.GetString($content,$offset,$logItem["datastruct"]["cbWeb"] )  
    $offset= $offset+ $logItem["datastruct"]["cbWeb"] +1
    
    
    $logItem["doc"]   = $enc.GetString($content,$offset,$logItem["datastruct"]["cbDoc"] )  
    $offset= $offset+ $logItem["datastruct"]["cbDoc"] +1
    
    
    $logItem["user"]   = $enc.GetString($content,$offset,$logItem["datastruct"]["cbUser"] )  
    $offset= $offset+ $logItem["datastruct"]["cbUser"] +1
    
    $fileoffset = $fileoffset + $logItem["cbEntrySize"]
    
    $logItem
    
}


