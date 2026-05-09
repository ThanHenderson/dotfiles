;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(require 'subr-x)

(defun than/non-empty-string-or-nil (value)
  (let ((trimmed (string-trim (or value ""))))
    (unless (string-empty-p trimmed)
      trimmed)))

(defun than/git-config-or-nil (key)
  (than/non-empty-string-or-nil
   (shell-command-to-string (concat "git config --global " key " 2>/dev/null"))))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name (or (than/non-empty-string-or-nil (getenv "DOOM_USER_FULL_NAME"))
                         (than/git-config-or-nil "user.name"))
      user-mail-address (or (than/non-empty-string-or-nil (getenv "DOOM_USER_EMAIL"))
                            (than/git-config-or-nil "user.email")))

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
(setq doom-font (font-spec :family "Go Mono" :size 13 :weight 'Bold))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq initial-frame-alist
      (append initial-frame-alist
              '((left   . 0)
                (top    . 0)
                (width  . 100)
                (height . 80))))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(defvar than/org-directory (expand-file-name "~/org/"))
(when (file-directory-p than/org-directory)
  (setq org-directory than/org-directory))

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
;;(with-eval-after-load 'lsp-mode
;;  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\obj-.*\\'"))

(setq lsp-enable-file-watchers nil)

(global-display-fill-column-indicator-mode)
(setq display-fill-column-indicator-column 80)
(setq display-fill-column-indicator-character ?|)

;; org journal
(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%A, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

(when (file-directory-p than/org-directory)
  (setq org-agenda-files (directory-files-recursively than/org-directory "\\.org$")))

;; org roam
(after! org
  (let ((roam-directory (expand-file-name "~/Documents/org/roam/")))
    (when (file-directory-p roam-directory)
      (setq org-roam-directory roam-directory
            org-roam-index-file (expand-file-name "index.org" roam-directory)))))

;; Mappings
(map! :leader "e h" #'org-html-export-to-html)
(map! :leader "e c" #'org-babel-execute-src-block)
