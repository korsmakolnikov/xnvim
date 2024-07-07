;; Author: korsmakolnikov
;; Github: www.github.com/korsmakolnikov/xnvim
;; 
;; autocmd -> filetype -> lambda dispatch
;;                          |
;;                          v
;;                       register -> layer -> view -> options -> hotkeys -> treesitter -> lsp -> autocompletition -> dap adapter -> autocmd
;;
;; register -> filetype -> options -> plugins -> external deps -> _G.layer_registered

;; register persists in memory the layers
;; configuration phase
;; Log /home/blacksheep/.local/state/nvim/lsp.log
;; Status panel
(local r {})

(local status {:execution_context [] :executed_layer []})
(fn update_execution_context [filetype]
  (print (.. "executed context " filetype))
  (table.insert (. status :execution_context) filetype))

(fn get-status [] status)

(local register (lambda [?filetype ?opts]
                  (case [?filetype ?opts]
                    [nil nil] r
                    [nil] r
                    _ ((lambda []
                         (tset r ?filetype ?opts)
                         r)))))

(fn execute_layer [filetype layer]
  (update_execution_context filetype)
  (layer))

;; layer dispatch to a series of utility to execute different piece of configuration
;; run-time phase
(fn layer [filetype]
  (if (. r filetype)
      (each [_ v (pairs (. r filetype))]
        (execute_layer filetype v))))

(register :text {:option (lambda []
                           (_G.vim.cmd ":setlocal spell spelllang=en_us,it"))
                 :visual (lambda []
                           (_G.vim.cmd ":set tw=80"))})

;;(layer :text)

;; deactivate_layer is the opposite of layer. It shutdown the entire active layer
;; is it needed?
(fn deactivate_layer [filetype register]
  (print filetype register)
  nil)

{: layer : register : deactivate_layer : get-status}

