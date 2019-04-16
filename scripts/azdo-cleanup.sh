#!/bin/bash
set -eou pipefail
source ./scripts/variables.sh

curl -u $(presenter):$(PAT) --request DELETE "https://vsrm.dev.azure.com/$(organization)/$(project)/_apis/release/definitions/$(releaseDef)?forceDelete=true&api-version=5.0" 

if curl -u $(presenter):$(PAT) --request GET "https://vsrm.dev.azure.com/$(organization)/$(project)/_apis/release/definitions/$(releaseDef)?api-version=5.0" ; then echo "$(releaseDef) not deleted. Please check your PAT and try again."
else echo "$(organization) $(project) Release Definition $(releaseDef) has been successfully deleted."
fi

sleep 10
curl -u $(presenter):$(PAT) --request DELETE "https://dev.azure.com/$(organization)/$(project)/_apis/build/definitions/$(buildDef)?api-version=5.0" 

if curl -u $(presenter):$(PAT) --request GET https://dev.azure.com/$(organization)/$(project)/_apis/build/definitions/$(buildDef)?api-version=5.0 ; then echo "$(buildDef) not deleted. Please check your PAT and try again."
else echo "$(organization) $(project) Build Definition $(buildDef) has been successfully deleted."
fi
