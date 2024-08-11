"-----------------------------------------------------------------------------"
" Vim-lsp autocompletion
"-----------------------------------------------------------------------------"
" Request completion items
function! ddc_vim_lsp#request(server_name, id) abort
  let server = lsp#get_server_info(a:server_name)
  let position = lsp#get_position()
  call lsp#send_request(a:server_name, {
    \ 'method': 'textDocument/completion',
    \ 'params': {
    \   'textDocument': lsp#get_text_document_identifier(),
    \   'position': position,
    \ },
    \ 'on_notification': function('ddc_vim_lsp#_callback', [server, position, a:id]),
  \ })
endfunction

" Return completion servers
function! ddc_vim_lsp#get_completion_servers(ignoreCompleteProvider) abort
  let names = []
  for server_name in lsp#get_allowed_servers()
    let capabilities = lsp#get_server_capabilities(server_name)
    if a:ignoreCompleteProvider
      call add(names, server_name)
    else
      if has_key(capabilities, 'completionProvider')
        call add(names, server_name)
      endif
    endif
  endfor
  return names
endfunction

" Return completion items
function! ddc_vim_lsp#_callback(server, position, id, data) abort
  if lsp#client#is_error(a:data) || !has_key(a:data, 'response') || !has_key(a:data['response'], 'result')
    return
  endif
  let opts = {
    \ 'server': a:server,
    \ 'position': a:position,
    \ 'response': a:data['response'],
  \ }
  let items = lsp#omni#get_vim_completion_items(opts)['items']
  for item in items
    if has_key(item, 'abbr')
      call remove(item, 'abbr')  " annoyingly long
    endif
  endfor
  if type(a:data['response']['result']) == 4 && has_key(a:data['response']['result'], 'isIncomplete')
    let incomplete = a:data['response']['result']['isIncomplete']
  else
    let incomplete = v:false
  endif
  call ddc#callback(a:id, {'items': items, 'isIncomplete': incomplete})
endfunction
