;;; ac-source-ispell.el --- Ispell words source for auto-complete-mode

;; Copyright (C) 2010 tequilasunset

;; Author:   tequilasunset <tequilasunset.mac@gmail.com>
;; Keywords: ispell
;; Version:  0.1

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;

;;; Requirements:

;;   auto-complete-mode:
;;
;;     http://cx4a.org/software/auto-complete/
;;

;;; Commentary:

;;; Code:

(require 'auto-complete)
(require 'ispell)

(defvar ac-ispell-cache (make-hash-table :test 'equal))
;; (defvar ac-ispell-cache (make-hash-table :test 'equal :size 17576)) ; 17576=26^3

(defun ac-candidate-ispell-words ()
  (let* ((key (downcase (substring ac-prefix 0 3)))
         (cache (gethash key ac-ispell-cache)))
    (if cache
        cache
      (let ((value (lookup-words (concat key "*") ispell-complete-word-dict)))
        (puthash key value ac-ispell-cache)
        value))))

(defvar ac-source-ispell
  '((candidates . ac-candidate-ispell-words)
    ;; (symbol . "i")
    (requires . 3))
  "Source for ispell.")

(provide 'ac-source-ispell)

;;; ac-source-ispell.el ends here
