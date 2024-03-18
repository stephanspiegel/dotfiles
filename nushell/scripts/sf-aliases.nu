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

export copyaccesstoken [] {
    sf org display --json | from json | get result.accessToken | pbcopy
    print 'Access token copied to clipboard'
}

export alias fsl='sfdx force:source:pull'
export alias fsp='sfdx force:source:push'
export alias fol='sfdx org:list'
export alias fod = sf org display --json | from json
export alias foo='sf org open'
export alias fstr='export SFDX_SOURCE_TRACKING_BATCH_SIZE=1000 && sfdx project reset tracking --no-prompt'
export alias sdfx='sfdx'
export alias devcons='sf org open --path _ui/common/apex/debug/ApexCSIPage'
 
