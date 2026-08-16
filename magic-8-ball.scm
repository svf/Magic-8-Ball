;;; magic-8-ball.scm
;;; A Magic 8-Ball oracle for CHICKEN Scheme.
;;;
;;; Usage:
;;;   csi -script magic-8-ball.scm "Will it rain tomorrow?"
;;;   csi -script magic-8-ball.scm            ; prompts interactively
;;;
;;; Or compiled:
;;;   csc magic-8-ball.scm -o magic-8-ball
;;;   ./magic-8-ball "Should I take the job?"

(import (chicken random)
        (chicken process-context)
        (chicken string))

;; The 8-ball emoji, by codepoint so the source stays plain ASCII.
(define eight-ball (string (integer->char #x1F3B1)))

(define answers
  (vector
    ;; Affirmative
    "It is certain."
    "It is decidedly so."
    "Without a doubt."
    "Yes, definitely."
    "You may rely on it."
    "As I see it, yes."
    "Most likely."
    "Outlook good."
    "Yes."
    "Signs point to yes."
    ;; Non-committal
    "Reply hazy, try again."
    "Ask again later."
    "Better not tell you now."
    "Cannot predict now."
    "Concentrate and ask again."
    ;; Negative
    "Don't count on it."
    "My reply is no."
    "My sources say no."
    "Outlook not so good."
    "Very doubtful."))

;; Give it a good shake.
(define (shake)
  (vector-ref answers (pseudo-random-integer (vector-length answers))))

(define (ask question)
  (print eight-ball " " question)
  (print eight-ball " " (shake)))

(define (prompt-and-ask)
  (display eight-ball)
  (display " Ask the Magic 8-Ball a yes-or-no question: ")
  (flush-output)
  (let ((line (read-line)))
    (if (or (eof-object? line) (string-null? (string-trim line)))
        (print eight-ball " No question, no answer. The 8-Ball stays silent.")
        (ask (string-trim line)))))

(define (main)
  (let ((args (command-line-arguments)))
    (if (null? args)
        (prompt-and-ask)
        (ask (string-intersperse args " ")))))

(main)
