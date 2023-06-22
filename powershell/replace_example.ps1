#replace subscription
$subscription = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
$filled = $subscription -replace "\w","0"
$filled

#replace casenumber
$casenumber = "xxxxxxxxxxxxxxxx"
$casenumber = $casenumber -replace "\w","x"
$casenumber

