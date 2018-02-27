#check status of scheduler process_F07 or Process_F33
#calcualte the duration of the process running from last time
#if the process is stock the duration will be greater than two hours , hence it will send email
#we can further add code to kill and restart the same scheduler or another.

function Check_Scheduler
{
    param([int]$filename) 
    if($filename -eq 33)
        {
            $Scheduler="Process_F33"
        }
    elseif($filename -eq 07)
        {
             $Scheduler="Process_F07"
        }

    $status=(Get-ScheduledTask | Where TaskName -EQ $Scheduler).State 

#read from a text file
    $startTime=(Get-Content -Path E:\.....\time.txt) 
    $endTime = Get-Date -format HH:mm:ss
#calculate time difference
    $TimeDiff = New-TimeSpan $startTime $endTime
    if ($TimeDiff.Hours -lt 0) 
    {
	    $Hrs = ($TimeDiff.Hours) + 23
	    $Mins = ($TimeDiff.Minutes) + 59
	    $Secs = ($TimeDiff.Seconds) + 59
    }
    else
    {
	    $Hrs = $TimeDiff.Hours
	    $Mins = $TimeDiff.Minutes
	    $Secs = $TimeDiff.Seconds }
    $Difference = '{0:00}:{1:00}:{2:00}' -f $Hrs,$Mins,$Secs

    if($status -eq "Running")
        {
            if ($Hrs -gt 2)
            {
                #Stop-ScheduledTask -TaskName $Scheduler
                echo "Sending email"
                . .\GroupEmail.ps1; Send-Mail -group 'IT' -bodypath 'E:\.....\Body.txt' -subject "$Scheduler scheduler Process Failed"
            }
        }

}