[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string[]]$GruppenName,

    [string]$LDAPDestinationpath = "OU=Gruppen,OU=Infrastruktur,OU=Struktur,DC=ppedv,DC=test" 
    )

foreach($Name in $GruppenName)
{
New-ADGroup -GroupCategory:"Security" -GroupScope:"DomainLocal" -Name:"DL-$GruppenName-R" -Path:"$LDAPDestinationpath" -SamAccountName:"DL-$GruppenName-R" -Server:"Server1.ppedv.test"
New-ADGroup -GroupCategory:"Security" -GroupScope:"DomainLocal" -Name:"DL-$GruppenName-W" -Path:"$LDAPDestinationpath" -SamAccountName:"DL-$GruppenName-W" -Server:"Server1.ppedv.test"
Add-ADPrincipalGroupMembership -Identity:"CN=DL-$GruppenName-W,$LDAPDestinationpath" -MemberOf:"CN=DL-$GruppenName-R,$LDAPDestinationpath" -Server:"Server1.ppedv.test"
New-ADGroup -GroupCategory:"Security" -GroupScope:"DomainLocal" -Name:"DL-$GruppenName-F" -Path:"$LDAPDestinationpath" -SamAccountName:"DL-$GruppenName-F" -Server:"Server1.ppedv.test"
Add-ADPrincipalGroupMembership -Identity:"CN=DL-$GruppenName-F,$LDAPDestinationpath" -MemberOf:"CN=DL-$GruppenName-W,$LDAPDestinationpath" -Server:"Server1.ppedv.test"
}

