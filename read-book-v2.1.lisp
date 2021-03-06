;;; 日英読み上げ装置ver.2.1 [2017-03-31 09:46:53]
(defun set-tts (lst)
	(unless (null lst)
		(if (standard-char-p (car lst))
				(setq tts "festival --tts")
				(progn
					(setq lst (delete #\Newline lst))
					(setq tts "ojtalk")))
		(format t "~A~%" lst)
		(asdf:run-shell-command (concatenate 'string "echo '" lst "'| " tts)))) ; => SET-TTS

(defun read-book (file)
	(setq lst ())
	(with-open-file (in file :direction :input)
		(do ((char (read-char in nil 'eof)
							 (read-char in nil 'eof)))
				((eql char 'eof))
			(when (or (and (not (null lst))
										 (not (eq (type-of char) (type-of (car lst)))))
								(char-equal char #\。)
								(char-equal char #\.)
								(char-equal char #\！)
								(char-equal char #\!)
								(char-equal char #\？)
								(char-equal char #\?)
								(char-equal char #\:)
								(char-equal char #\;)
								)
				(set-tts (nreverse lst))
				(setq lst ()))
			(setq lst (cons char lst)))))			; => READ-BOOK
