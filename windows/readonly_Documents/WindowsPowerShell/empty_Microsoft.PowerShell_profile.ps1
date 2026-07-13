$utils = @('ls','cat','chmod','cp','cut','date','echo','env','id','ln','mkdir','mv','pwd','rm','rmdir','sleep','sort','tail','tee','touch','uname','uniq','wc')

foreach ($u in $utils) { 
    if (Get-Alias $u -EA SilentlyContinue) { 
        Remove-Item "alias:\$u" -Force 
    } 
}
