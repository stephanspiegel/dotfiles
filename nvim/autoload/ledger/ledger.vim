function ledger#ledger#sort()
    :diffoff!
    :diffthis
    :Ledger print --sort 'date'
    :set ma
    :set ft=ledger
    :%LedgerAlign
    :diffthis
endfunction

