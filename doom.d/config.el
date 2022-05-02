;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Sean Ray"
      user-mail-address "seanray410@gmail.com")

;; speedup start time

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "Terminus (TTF)" :size 12)
      doom-variable-pitch-font (font-spec :family "Terminus (TTF)") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Terminus (TTF)" :size 12)
      doom-big-font (font-spec :family "Terminus (TTF)" :size 12))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)
(setq doom-themes-neotree-file-icons t)
(setq doom-themes-org-fontify-special-tags t)
(setq doom-gruvbox-brighter-comments t)
(setq doom-gruvbox-dark-variant "soft")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

; don't write contents of " register after pasting on a block
(setq evil-kill-on-visual-paste nil)

; yank by lines and not based on screen lines
:init
(setq evil-respect-visual-line-mode t)

; remove highlights after search
:config
(map! :m "C-l" #'evil-ex-nohighlight)

; help emacs convert weird image formats
(setq image-use-external-converter t)

; make fringe very small
(set-fringe-mode 0)

; allow underscores to be word delimeters
(modify-syntax-entry ?_ "w")

; allow more bytes to eb read
(setq read-process-output-max (* 1024 1024))

(setq-default line-spacing nil)

(use-package! cape
  :config
  (map! (:prefix "C-c f"
             :i "p" #'completion-at-point
             :i "d" #'cape-dabbrev
             :i "f" #'cape-file
             :i "k" #'cape-keyword
             :i "i" #'cape-ispell
             :i "s" #'cape-symbol
             :i "t" #'cape-tex))
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package! corfu
  :bind (:map corfu-map
         ("<escape>" . corfu-quit)
         ("C-l" . corfu-insert)
         ("C-j" . corfu-next)
         ("C-k" . corfu-previous))
  :config
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-prefix 2
        corfu-auto-delay 0.01
        corfu-separator ?\s
        corfu-quit-at-boundary nil
        corfu-preselect-first nil
        corfu-preview-current nil
        corfu-on-exact-match nil
        corfu-quit-no-match t
        corfu-echo-documentation t
        corfu-scroll-margin 10)
  (advice-add 'corfu--setup :after 'evil-normalize-keymaps)
  (advice-add 'corfu--teardown :after 'evil-normalize-keymaps)
  (evil-make-overriding-map corfu-map)
  (map! :i "C-e" #'completion-at-point)
  :init
  (global-corfu-mode +1)
  (corfu-doc-mode +1))

(after! evil-org
  (map! (:map evil-org-mode-map
         :i "C-j" nil
         :i "C-k" nil
         :i "C-;" nil
         :i "C-l" nil
         :i "<return>" nil
         :i "RET" nil)))

(use-package! corfu-doc
  :bind (:map corfu-map
         ("C-;" . corfu-doc-toggle)
         ("C-n" . corfu-doc-scroll-down)
         ("C-p" . corfu-doc-scroll-up))
  :config
  (setq corfu-doc-delay 0.2
        corfu-doc-max-width 80
        corfu-doc-max-height 40)
  :init
  (corfu-doc-mode +1))

(use-package! kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; no icons
(after! all-the-icons
    (defun +my/disable-all-the-icons (&rest _)
        nil)
    (dolist (fn '(all-the-icons-octicon
                     all-the-icons-material
                     all-the-icons-faicon
                     all-the-icons-fileicon
                     all-the-icons-wicon
                     all-the-icons-alltheicon))
        (advice-add fn :override #'+my/disable-all-the-icons)))

(setq
 dired-open-extensions
 '(("gif" . "nsxiv -a")
   ("jpg" . "nsxiv")
   ("jpeg". "nsxiv")
   ("png" . "nsxiv")
   ("xcf" . "gimp")
   ("mkv" . "mpv")
   ("mp4" . "mpv")
   ("mov" . "mpv"))
 delete-by-moving-to-trash t)

(custom-set-variables
 '(mini-frame-show-parameters
   '((top . 10)
     (width . 0.4)
     (left . 0.5))))

;;(ivy-mode)
;;(require 'ivy-posframe)
;; display at `ivy-posframe-style'
;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
 ;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
;;(ivy-posframe-mode 1)

(setq
 doom-modeline-height 18
 doom-modeline-bar-width 3
 doom-modeline-major-mode-icon t
 doom-modeline-enable-word-count t
 doom-modeline-buffer-file-name-style 'truncate-except-project
 all-the-icons-scale-factor 1)
(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar matches modals window-number buffer-info remote-host buffer-position word-count selection-info)
    '(irc misc-info input-method buffer-encoding major-mode lsp process vcs checker "  ")))

(setq
 evil-vsplit-window-right t
 evil-split-window-below t
 window-divider-default-bottom-width 0
 window-divider-default-right-width 0)

; adjust window sizes with janky keybinds
(map! :leader
      "TAB h" #'evil-window-increase-width
      "TAB l" #'evil-window-decrease-width
      "TAB j" #'evil-window-decrease-height
      "TAB k" #'evil-window-increase-height)

; cycle through tabs
(map! "M-TAB" #'+tabs:next-or-goto)

;; "I use vim btw"
(defun sean/display-splash ()
  (mapc (lambda (line)
          (insert (propertize (+doom-dashboard--center +doom-dashboard--width line)
                              'face 'doom-dashboard-banner) " ")
          (insert "\n"))
      '("                    .                    "
        "    ##############..... ##############   "
        "    ##############......##############   "
        "      ##########..........##########     "
        "      ##########........##########       "
        "      ##########.......##########        "
        "      ##########.....##########..        "
        "      ##########....##########.....      "
        "    ..##########..##########.........    "
        "  ....##########.#########.............  "
        "    ..################JJJ............    "
        "      ################.............      "
        "      ##############.JJJ.JJJJJJJJJJ      "
        "      ############...JJ...JJ..JJ  JJ     "
        "      ##########....JJ...JJ..JJ  JJ      "
        "      ########......JJJ..JJJ JJJ JJJ     "
        "      ######    .........                "
        "                  .....                  "
        "                    .                    ")))

(setq +doom-dashboard-ascii-banner-fn #'sean/display-splash)

(defun consult-set-font ()
  "Select xfont."
  (interactive)
  (set-frame-font
   (completing-read "Choose font:"
                    (x-list-fonts "*"))))

(map! :desc "Ripgrep on projects"
      "C-;" #'+default/search-project)
(setq projectile-ignored-projects '("~/" "/tmp/" "~/.emacs.d/"))

(map! :leader "l r" #'vertico-next)

(map! :leader
      "," #'consult-buffer
      "<" #'consult-buffer-other-window)

(after! consult
  (consult-customize
   consult-buffer :preview-key (kbd "C-,")
   consult-buffer-other-window :preview-key (kbd "C-,")))

(use-package! affe
  :after orderless
  :config
  (consult-customize
   affe-grep
   :prompt "Search in Project  ")
  (consult-customize
   affe-find
   :prompt "Find file in Project  "))

(setq
 which-key-idle-delay 0.3)
(after! which-key (setq-hook! 'which-key-init-buffer-hook line-spacing 0))

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

(global-set-key (kbd "C-x M-m") 'shell)
(global-set-key [f1] 'neotree-toggle)

(setq winum-keymap
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "C-`") 'winum-select-window-by-number)
      (define-key map (kbd "C-²") 'winum-select-window-by-number)
      (define-key map (kbd "M-0") 'winum-select-window-0-or-10)
      (define-key map (kbd "M-1") 'winum-select-window-1)
      (define-key map (kbd "M-2") 'winum-select-window-2)
      (define-key map (kbd "M-3") 'winum-select-window-3)
      (define-key map (kbd "M-4") 'winum-select-window-4)
      (define-key map (kbd "M-5") 'winum-select-window-5)
      (define-key map (kbd "M-6") 'winum-select-window-6)
      (define-key map (kbd "M-7") 'winum-select-window-7)
      (define-key map (kbd "M-8") 'winum-select-window-8)
      map))

(after! lsp-mode
    (setq lsp-restart 'ignore
        lsp-headerline-breadcrumb-enable nil
        lsp-enable-symbol-highlighting t
        lsp-enable-indentation nil
        lsp-eldoc-enable-hover t
        lsp-eldoc-render-all nil
        lsp-signature-render-documentation nil
        lsp-signature-auto-activate nil
        lsp-signature-doc-lines 1
        lsp-auto-guess-root nil
        lsp-enable-file-watchers nil
        lsp-enable-on-type-formatting nil)

    ;; Rust
    (setq
        lsp-rust-server 'rust-analyzer
        lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-rust-analyzer-inlay-hints-mode t
        lsp-rust-analyzer-server-display-inlay-hints nil)

    ;; C++
    (setq lsp-clients-clangd-args
        '("-j=4"
             "--malloc-trim"
             "--log=error"
             "--background-index"
             "--clang-tidy"
             "--cross-file-rename"
             "--completion-style=detailed"
             "--pch-storage=memory"
             "--header-insertion=never"
             "--header-insertion-decorators=0"))
    (add-to-list 'flycheck-disabled-checkers 'c/c++-clang)
    (add-to-list 'flycheck-disabled-checkers 'c/c++-gcc)
    (after! lsp-clangd (set-lsp-priority! 'clangd 2)))

(after! 'lsp-mode
  (setq lsp-log-io nil)
  (setq lsp-enable-folding nil)
  (setq lsp-enable-snippet t)
  (setq lsp-diagnostic-package :none)
  (setq lsp-enable-completion-at-point nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-enable-links nil)
  (setq lsp-restart 'auto-restart)
  (setq lsp-client-packages '(lsp-clients))
  (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored) ; json
  ;; don't ping LSP lanaguage server too frequently
  (defvar lsp-on-touch-time 0)
  (defadvice lsp-on-change (around lsp-on-change-hack activate)
    ;; don't run `lsp-on-change' too frequently
    (when (> (- (float-time (current-time))
                lsp-on-touch-time) 30) ;; 30 seconds
      (setq lsp-on-touch-time (float-time (current-time)))
      ad-do-it))
)

(after! lsp-ui
    (setq lsp-ui-sideline-enable nil
        lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-show-diagnostics nil
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-code-actions nil)

    (setq lsp-ui-peek-enable t
        lsp-ui-peek-always-show t
        lsp-ui-peek-show-directory t)

    (setq lsp-ui-doc-enable t)
    (setq lsp-ui-imenu-enable t))

(after! rustic
    (setq
        rustic-lsp-server 'rust-analyzer
        rustic-format-on-save nil))

(use-package! winum)

(defun winum-assign-0-to-neotree ()
  (when (string-match-p (buffer-name) ".*\\*NeoTree\\*.*") 10))

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(add-to-list 'winum-assign-functions #'winum-assign-0-to-neotree)

(set-face-attribute 'winum-face nil :weight 'bold)

(setq window-numbering-scope            'global
      winum-reverse-frame-list          nil
      winum-auto-assign-0-to-minibuffer t
      winum-auto-setup-mode-line        t
      winum-format                      " %s "
      winum-mode-line-position          1
      winum-ignored-buffers             '(" *which-key*")
      winum-ignored-buffers-regexp      '(" \\*Treemacs-.*"))



;; I personally like word wrap
(+global-word-wrap-mode)

;; make menus appear at the top so they're more comfortable to read
(mini-frame-mode)

; completetion
(global-corfu-mode)

(winum-mode)

; ide time tracking
(global-wakatime-mode)

(run-with-idle-timer
 5 nil
 (lambda ()
   (setq gc-cons-threshold gc-cons-threshold-original)
   (setq file-name-handler-alist file-name-handler-alist-original)
   (makunbound 'gc-cons-threshold-original)
   (makunbound 'file-name-handler-alist-original)
   (message "gc-cons-threshold and file-name-handler-alist restored")))
