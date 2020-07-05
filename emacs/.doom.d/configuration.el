  (setq user-full-name "João M. Freitas"
        user-mail-address "joaj.freitas@gmail.com"
        calendar-latitude 38.7426654
        calendar-longitude -9.1315425
        calendar-location-name "Lisbon, PT")

(setq doom-theme 'doom-gruvbox)

(setq doom-font (font-spec :family "Fira Code" :size 12))

(setq display-line-numbers-type t)

;; isearch lazy cleanup
(setq lazy-highlight-cleanup nil)
(setq lazy-highlight-max-at-a-time nil)
(setq lazy-highlight-initial-delay 0)

;;(set-frame-parameter (selected-frame) 'alpha '(92 . 90))
;;(add-to-list 'default-frame-alist '(alpha . (92 . 90)))

(projectile-add-known-project "~/fst/software10e")
(projectile-add-known-project "~/ist/a5s2/CPD/project")
(projectile-add-known-project "~/projects/learn/rust/variables")

(setq org-directory "~/org-wiki/")

(setq org-publish-project-alist
      '(
        ("org-wiki"
        :base-directory "~/org-wiki/"
        :base-extension "org"
        :publishing-directory "~/public_html/"
        :recursive t
        :publishing-function org-html-publish-to-html
        :headline-levels 4             ; Just the default for this project.
        :auto-preamble t
        :style "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://gongzhitaao.org/orgcss/org.css\"/>"
        )

        ("org-static"
        :base-directory "~/org/"
        :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
        :publishing-directory "~/public_html/"
        :recursive t
        :publishing-function org-publish-attachment
        )
        ("org" :components ("org-wiki" "org-static"))

      ))

(setq org-ellipsis "⤵")

(defun org-convert-markdown ()
    "Convert the current buffer's content from markdown to orgmode format and save it with the current buffer's file name but with .org extension."
    (interactive)
    (shell-command-on-region (point-min) (point-max)
                             (format "pandoc -f markdown -t org -o %s"
                                     (concat (file-name-sans-extension (buffer-file-name)) ".org"))))

(setq org-roam-directory "~/org-wiki")

(require 'org-roam-protocol)

(use-package! org-roam
  :commands (org-roam-insert org-roam-find-file org-roam org-roam-show-graph)
  :init
  (setq org-roam-directory org-directory)
  (setq org-roam-graph-viewer "/usr/bin/brave")
  (map! :leader
      :prefix "n"
      :desc "Org-Roam-Insert" "i" #'org-roam-insert
      :desc "Org-Roam-Find"   "/" #'org-roam-find-file
      :desc "Org-Roam-Buffer" "r" #'org-roam
      :desc "Org-Roam-Show-Graph" "g" #'org-roam-show-graph)
  :config
  (org-roam-mode +1)
  (require 'org-roam-protocol)) ;; require org-roam-protocol here
