(local vim_api _G.vim.api)
(local format-sync-grp (vim_api.nvim_create_augroup :GoFormat {}))

(vim_api.nvim_create_autocmd :BufWritePre
                             {:callback (fn []
                                          ((. (require :go.format) :goimport)))
                              :group format-sync-grp
                              :pattern :*.go})

(vim_api.nvim_create_autocmd :BufEnter
                             {:command ":set autoindent noexpandtab tabstop=4 shiftwidth=4"
                              :pattern [:*.rs :*.s :*.asm]})

(vim_api.nvim_create_autocmd :BufEnter
                             {:command ":set autoindent noexpandtab tabstop=8 shiftwidth=8"
                              :pattern :*.go})

(vim_api.nvim_create_autocmd :BufEnter
                             {:group (vim_api.nvim_create_augroup :LayerGroup
                                                                  {:clear false})
                              :pattern "*.*"
                              :callback (lambda [opts]
                                          (let [layer (require :layer)]
                                            (let [filetype (. (. _G.vim.bo
                                                                 opts.buf)
                                                              :filetype)]
                                              ;; here the generic dispatch to layer
                                              (layer.layer filetype))))})

