#!/usr/bin/env nu

export alias foo = sf org open
export alias newclass = sf force:apex:class:create

export def pdp [] {
    sf project deploy preview --json | from json
}

export def prp [] {
    sf project retrieve preview --json | from json
}

export def pds [] {
    sf project deploy start --json | from json
}

export def copyaccesstoken [] {
    sf org display --json | from json | get result.accessToken | pbcopy
    print 'Access token copied to clipboard'
}

export alias foo = sf org open
export alias fstr = SFDX_SOURCE_TRACKING_BATCH_SIZE=1000 sfdx project reset tracking --no-prompt
export alias devcons = sf org open --path _ui/common/apex/debug/ApexCSIPage
 
