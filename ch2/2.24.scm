;; For the expression (list 1 (list 2 (list 3 4)))
;;
;; the interper prints:
;;
;;
;;                    (1 (2 (3 4)))
;;
;;
;; the box-and-pointer structure is:
;;
;;
;;           ->[*][*]->[*][/]
;;              |       |
;;              v       v
;;             [1]     [*][*]->[*][/]
;;                      |       |
;;                      v       v
;;                     [2]     [*][*]->[*][/]
;;          		       |       |
;;                                v       v
;;          		      [3]     [4]
;;
;;
;; and lastly the tree representation is:
;;
;;
;;                    [.]
;;                   /   \
;;                  1    [.]
;;                      /
;;                    [.]
;;                   /   \
;;                  2    [.]
;;                      /
;;                    [.]
;;                   /   \
;;                  3     [.]
;;                       /
;;                      4
