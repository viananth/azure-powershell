# Azure PowerShell AutoRest Configuration

> Values
``` yaml
azure: true
powershell: true
branch: azsadmin
repo: https://github.com/viananth/azure-rest-api-specs/blob/$(branch)
```

> Names
``` yaml
prefix: Azs
subject-prefix: Network
module-name: $(prefix).$(service-name)
namespace: Microsoft.Azure.PowerShell.Cmdlets.$(service-name)
```

> Folders
``` yaml
clear-output-folder: true
output-folder: .
```

> Directives
``` yaml
directive:
  - where:
      subject: Operation
    hide: true
```