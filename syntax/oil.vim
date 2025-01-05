if exists("b:current_syntax")
    finish
endif

syn match oilId /^\/\d* / conceal

syn match goTest /\w*_test\.go$/
syn match goMock /mock_.*\.go$/

highlight goTest ctermfg=Gray guifg=#928374
highlight goMock ctermfg=Gray guifg=#665c54

let b:current_syntac = "oil"
