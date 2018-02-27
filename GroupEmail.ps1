
#Reads the email id from xml file
#can send multiple attachemnt of any type
#can read the body content from test file
#this script will eliminate batch email sending script(blat) and we dont need to edit email ids in each batch script individually,
#just change it in xml.


function Send-Mail{ param([string]$group,[string]$bodypath,[string]$subject)
$from="admin@admin.com"
$smtp="somesmtp.smtp.com"
$body=Get-Content -path $bodypath | Out-String  

#Read the xml file and typecast it to System.Xml.XmlDocument
[Xml]$XmlData=Get-Content -path E:\.......\Email.xml
$to = $XmlData.emaillist.group |Where-Object {$_.id -eq $group} |Select-Object -Expand emailid
Send-MailMessage -From $from -To $to -Subject $subject -Body $body -SmtpServer $smtp
 }