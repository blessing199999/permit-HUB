;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WHITELIST ACCESS CONTRACT
;; -------------------------------------------------------------
;; Author: GPT-5
;; Purpose: Demonstrate access control in Clarity
;; Compatible: Clarinet v1.0+ (Stacks 2.5+)
;;
;; Features:
;; - Admin-only whitelist management
;; - Add / remove users
;; - Check whitelist status
;; - Restricted access function
;; - Change admin address
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; -------------------------------------------------------------
;; Global admin (deployer by default)
;; -------------------------------------------------------------
(define-data-var admin principal tx-sender)

;; -------------------------------------------------------------
;; Storage: whitelist map
;; Key: user principal
;; Value: { allowed: bool }
;; -------------------------------------------------------------
(define-map whitelist
  { user: principal }
  { allowed: bool }
)

;; -------------------------------------------------------------
;; Read-only functions
;; -------------------------------------------------------------

;; Check if a principal is the current admin
(define-read-only (is-admin (who principal))
  (is-eq who (var-get admin))
)

;; Check if a user is whitelisted
(define-read-only (is-whitelisted (who principal))
  (default-to false (get allowed (map-get? whitelist { user: who })))
)

;; -------------------------------------------------------------
;; Public functions: Admin-only operations
;; -------------------------------------------------------------

;; Add a user to the whitelist
(define-public (add-to-whitelist (user principal))
  (begin
    (if (not (is-admin tx-sender))
        (err u401) ;; Unauthorized
        (begin
          (map-set whitelist { user: user } { allowed: true })
          (ok "User added to whitelist")
        )
    )
  )
)

;; Remove a user from the whitelist
(define-public (remove-from-whitelist (user principal))
  (begin
    (if (not (is-admin tx-sender))
        (err u401)
        (begin
          (map-delete whitelist { user: user })
          (ok "User removed from whitelist")
        )
    )
  )
)

;; Transfer admin privileges to a new address
(define-public (set-admin (new-admin principal))
  (begin
    (if (not (is-admin tx-sender))
        (err u401)
        (begin
          (var-set admin new-admin)
          (ok "Admin changed successfully")
        )
    )
  )
)

;; -------------------------------------------------------------
;; Restricted access function
;; -------------------------------------------------------------
;; Only callable by whitelisted addresses

(define-public (restricted-action)
  (begin
    (if (is-whitelisted tx-sender)
        (ok "Access granted: you are on the whitelist")
        (err u403) ;; Forbidden
    )
  )
)

;; -------------------------------------------------------------
;; Utility: Returns current admin
;; -------------------------------------------------------------
(define-read-only (get-admin)
  (var-get admin)
)
