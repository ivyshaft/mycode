# Usage: CheckSSL <fully-qualified-domain-name>
function CheckSSL($fqdn, $port=443) 
{
    try {
        $tcpSocket = New-Object Net.Sockets.TcpClient($fqdn, $port)
    } catch {
        Write-Warning "$($_.Exception.Message) / $fqdn"
        break
    }
    $tcpStream = $tcpSocket.GetStream()
    ""; "-- Target: $fqdn / " + $tcpSocket.Client.RemoteEndPoint.Address.IPAddressToString
    $sslStream = New-Object -TypeName Net.Security.SslStream($tcpStream, $false)
    $sslStream.AuthenticateAsClient($fqdn)  # If not valid, will display "remote certificate is invalid".
    $certinfo = New-Object -TypeName Security.Cryptography.X509Certificates.X509Certificate2(
        $sslStream.RemoteCertificate)

    $sslStream |
        Select-Object |
        Format-List -Property SslProtocol, CipherAlgorithm, HashAlgorithm, KeyExchangeAlgorithm,
            IsAuthenticated, IsEncrypted, IsSigned, CheckCertRevocationStatus
    $certinfo |
        Format-List -Property Subject, Issuer, FriendlyName, NotBefore, NotAfter, Thumbprint
    $certinfo.Extensions |
        Where-Object -FilterScript { $_.Oid.FriendlyName -Like 'subject alt*' } |
        ForEach-Object -Process { $_.Oid.FriendlyName; $_.Format($true) }

    $tcpSocket.Close() 
}

$fqdns = @($args)


$fqdns | ForEach-Object -Begin {} -Process {
    $datetime = Get-Date -Format "MMddyyyy-hhmm"
    $outfile = ".\Check_SSL_Results_$datetime.txt"
    CheckSSL $PSItem | Out-File $outfile -Append
} -End {
    $outfile | Invoke-Item
}
